function cleanupname(name)
    name |> (n -> replace(n, '-' => ' ')) |> strip
end

function firstletter(name)
    (string ∘ first ∘ cleanupname)(name)
end

function initial(name)
    name |> firstletter |> uppercase |> (i -> "$(i).")
end

function couple(name1, name2)
    "❤ $(initial(name1))  +  $(initial(name2)) ❤"
end
