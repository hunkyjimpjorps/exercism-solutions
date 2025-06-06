function isQuestion(str)
    endswith(strip(str), "?")
end

function isYelling(str)
    str == uppercase(str) && contains(str, r"[a-zA-Z]")
end

function isSilent(str)
    isempty(strip(str))
end

function bob(str)
    if isSilent(str)
        "Fine. Be that way!"
    elseif isYelling(str) && isQuestion(str)
        "Calm down, I know what I'm doing!"
    elseif isYelling(str)
        "Whoa, chill out!"
    elseif isQuestion(str)
        "Sure."
    else
        "Whatever."
    end
end
