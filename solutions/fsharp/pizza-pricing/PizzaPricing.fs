module PizzaPricing

type Pizza =
    | Margherita
    | Caprese
    | Formaggio
    | ExtraSauce of Pizza
    | ExtraToppings of Pizza

let rec pizzaPrice (pizza: Pizza) : int =
    match pizza with
    | Margherita -> 7
    | Caprese -> 9
    | Formaggio -> 10
    | ExtraSauce p -> pizzaPrice p + 1
    | ExtraToppings p -> pizzaPrice p + 2

let orderPrice (pizzas: Pizza list) : int =
    let surcharge =
        match pizzas with
        | [ _ ] -> 3
        | [ _; _ ] -> 2
        | _ -> 0

    List.sumBy pizzaPrice pizzas + surcharge
