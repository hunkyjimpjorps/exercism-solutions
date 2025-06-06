import gleam/string

pub opaque type TreasureChest(t) {
  TreasureChest(contents: t, password: String)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case string.length(password) {
    i if i < 8 -> Error("Password must be at least 8 characters long")
    _ -> Ok(TreasureChest(contents: contents, password: password))
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case chest.password {
    p if p == password -> Ok(chest.contents)
    _ -> Error("Incorrect password")
  }
}
