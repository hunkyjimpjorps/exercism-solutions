module DotDsl

open System

type Attr = string * string

type Node = { key: string; attrs: list<Attr> }

type Edge =
    { left: string
      right: string
      attrs: list<Attr> }

type Element =
    | Node of Node
    | Edge of Edge
    | Attribute of Attr

type Graph = list<Element>

let graph (children: list<Element>) : Graph = children

let attr key value = Attribute(key, value)

let node key attrs = Node { key = key; attrs = attrs }

let edge left right attrs =
    Edge
        { left = left
          right = right
          attrs = attrs }

let attrs (graph: Graph) =
    graph
    |> List.filter (function
        | Attribute _ -> true
        | _ -> false)
    |> List.sort

let nodes graph =
    graph
    |> List.filter (function
        | Node _ -> true
        | _ -> false)
    |> List.sort

let edges graph =
    graph
    |> List.filter (function
        | Edge _ -> true
        | _ -> false)
    |> List.sort
