module LinkedList

type MyLinkedList() =
    let mutable lst = List.empty
    let mutable lstLength = 0

    member this.Push x =
        lst <- x :: lst
        lstLength <- lstLength + 1

    member this.Pop =
        let popped = List.head lst
        lstLength <- lstLength - 1
        lst <- List.tail lst
        popped

    member this.Shift =
        let shifted = List.last lst
        lstLength <- lstLength - 1
        lst <- lst.[0..(lstLength - 1)]
        shifted

    member this.Unshift x =
        lst <- lst @ [ x ]
        lstLength <- lstLength + 1

let mkLinkedList () = MyLinkedList()
let pop (linkedList: MyLinkedList) = linkedList.Pop
let shift (linkedList: MyLinkedList) = linkedList.Shift
let push newValue (linkedList: MyLinkedList) = linkedList.Push(newValue)
let unshift newValue (linkedList: MyLinkedList) = linkedList.Unshift(newValue)
