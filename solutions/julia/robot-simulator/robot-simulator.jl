using MLStyle
using MLStyle.AbstractPatterns: literal
import Base: +

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

+(point::Point, step::Point) = Point(point.x + step.x, point.y + step.y)

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
        NORTH => robot.position + Point(0, unit)
        EAST => robot.position + Point(unit, 0)
        SOUTH => robot.position + Point(0, -unit)
        WEST => robot.position + Point(-unit, 0)
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