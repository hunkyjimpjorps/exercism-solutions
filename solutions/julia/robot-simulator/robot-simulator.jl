using MLStyle
using MLStyle.AbstractPatterns: literal

@enum Heading begin
    NORTH
    EAST
    WEST
    SOUTH
end

MLStyle.is_enum(::Heading) = true
MLStyle.pattern_uncall(d::Heading, _, _, _, _) = literal(d)

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
    robot.heading = @match robot.heading begin
        NORTH => EAST
        EAST => SOUTH
        SOUTH => WEST
        WEST => NORTH
    end
    return robot
end

function turn_left!(robot::Robot)
    robot.heading = @match robot.heading begin
        NORTH => WEST
        EAST => NORTH
        SOUTH => EAST
        WEST => SOUTH
    end
    return robot
end

function advance!(robot::Robot)
    unit = one(robot.position.x)
    robot.position = @match robot.heading begin
        NORTH => Point(robot.position.x, robot.position.y + unit)
        EAST => Point(robot.position.x + unit, robot.position.y)
        SOUTH => Point(robot.position.x, robot.position.y - unit)
        WEST => Point(robot.position.x - unit, robot.position.y)
    end
    return robot
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