function matching_brackets(original_str)
    open_stack = []
    str = replace(original_str, r"[^\[\]{}()]" => "")

    for c in str
        if is_opening_bracket(c)
            push!(open_stack, c)
        elseif !isempty(open_stack) && matched_bracket_pair(open_stack[end], c)
            pop!(open_stack)
        else
            return false
        end
    end
    isempty(open_stack) ? true : false
end

function matched_bracket_pair(left, right)
    (left == '(' && right == ')') ||
        (left == '[' && right == ']') ||
        (left == '{' && right == '}')
end

function is_opening_bracket(bracket)
    in(bracket, ['(', '{', '['])
end
