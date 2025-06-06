import gleam/queue.{type Queue}

pub opaque type CircularBuffer(t) {
  CircularBuffer(max_size: Int, size: Int, contents: Queue(t))
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(max_size: capacity, size: 0, contents: queue.new())
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case queue.pop_front(buffer.contents) {
    Ok(#(item, new_queue)) ->
      Ok(#(
        item,
        CircularBuffer(..buffer, size: buffer.size - 1, contents: new_queue),
      ))
    Error(Nil) -> Error(Nil)
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case buffer {
    b if b.max_size == b.size -> Error(Nil)
    b ->
      Ok(
        CircularBuffer(
          ..b,
          size: b.size + 1,
          contents: queue.push_back(b.contents, item),
        ),
      )
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  case buffer {
    b if b.max_size > b.size -> {
      let assert Ok(b) = write(b, item)
      b
    }
    b -> {
      let assert Ok(#(_, new_queue)) = queue.pop_front(b.contents)
      CircularBuffer(..b, contents: queue.push_back(new_queue, item))
    }
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  CircularBuffer(..buffer, size: 0, contents: queue.new())
}
