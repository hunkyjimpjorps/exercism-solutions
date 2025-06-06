using MLStyle
using MLStyle.AbstractPatterns: literal

@enum Heading NORTH EAST WEST SOUTH
is_enum(::Heading) = true
pattern_uncall(dir::Heading, _, _, _, _) = literal(dir)

struct Point{T}
    x::T
    y::T
end

mutable struct Robot
    position::Point{Int}
    heading::Heading
    Robot((x, y)::Tuple{Int,Int}, dir::Heading) = new(Point(x, y), dir)
    Robot(p::Point, dir::Heading) = new(p, dir)
end

function position(robot::Robot)
    robot.position
end

function heading(robot::Robot)
    robot.heading
end

function turn_right!(robot::Robot)
    h = @match robot.heading begin
        0 => EAST
        1 => SOUTH
        2 => WEST
        3 => NORTH
        _ => throw(DomainError(robot.heading))
    end
    return Robot(robot.position, h)
end

function turn_left!(robot::Robot)
    h = @match robot.heading begin
        0 => WEST
        1 => NORTH
        2 => EAST
        3 => SOUTH
        _ => throw(DomainError(robot.heading))
    end
    return Robot(robot.position, h)
end

function advance!(robot::Robot)
    unit = one(robot.position.x)
    p = @match robot.heading begin
        NORTH => Point(robot.position.x, robot.position.y + unit)
        EAST => Point(robot.position.x + unit, robot.position.y)
        SOUTH => Point(robot.position.x, robot.position.y - unit)
        WEST => Point(robot.position.x - unit, robot.position.y)
        _ => throw(DomainError(robot.heading))
    end
    return Robot(p, robot.heading)
end

function move!(robot::Robot, directions::AbstractString)
    for step in directions
        @match step begin
            'L' => turn_left!(robot)
            'R' => turn_right!(robot)
            'A' => advance!(robot)
            _ => throw(DomainError(step, "Unknown robot instruction"))
        end
    end
    return robot
end