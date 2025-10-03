const digits = [
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I",
]

function to_roman(number, table=digits, acc="")
  if number <= 0 && isempty(acc)
    throw(ErrorException("number must be positive ($number <= 0)"))
  elseif isempty(table)
    return acc
  else
    (val, sym), rest... = table
    if number >= val
      to_roman(number - val, table, acc * sym)
    else
      to_roman(number, rest, acc)
    end
  end
end
