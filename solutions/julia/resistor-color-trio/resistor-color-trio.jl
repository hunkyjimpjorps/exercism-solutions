using MLStyle

function matchcolor(color)
    @match color begin
        "black" => 0
        "brown" => 1
        "red" => 2
        "orange" => 3
        "yellow" => 4
        "green" => 5
        "blue" => 6
        "violet" => 7
        "grey" => 8
        "white" => 9
    end
end

function label(colors)
    resistance = @match colors begin
        [tens, ones, power] => 
            (matchcolor(tens) * 10 + matchcolor(ones)) * 10^(matchcolor(power))
    end

    @match resistance begin
        r && if r % 1000 == 0 end => "$(r ÷ 1000) kiloohms"
        r => "$r ohms"
    end
end
