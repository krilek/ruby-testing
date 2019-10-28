class Robot
    attr_reader :bearing
    attr_reader :coordinates
    @@directions = [:south, :west, :north, :east]
    @bearing = @@directions[0]
    @coordinates = [0, 0]

    def orient(direction)
        if(@@directions.include? direction)
            @bearing = direction
        else
            raise ArgumentError
        end
    end

    def turn_right
        i = @@directions.find_index(@bearing) + 1 
        @bearing = @@directions[i < @@directions.length ? i : 0]
    end

    def turn_left
        i = @@directions.find_index(@bearing) - 1 
        @bearing = @@directions[i >= 0 ? i : @@directions.length-1]
    end

    def at(x, y)
        @coordinates = [x,y]
    end
    
    def advance
        case @bearing
        when :south
          @coordinates[1] -= 1
        when :west
            @coordinates[0] -= 1
        when :north
            @coordinates[1] += 1
        when :east
            @coordinates[0] += 1
        end
    end
end

class Simulator
    @@instruction_set = {'R'=>:turn_right, 'A'=>:advance, 'L'=>:turn_left}
    def initialize
        
    end

    def instructions (instruction_str)
        instruction_str.split('').map{ |x| @@instruction_set[x]}
    end
    def place(robot, x:, y:, direction:)
        robot.at(x,y)
        robot.orient(direction)
    end
    def evaluate(robot, instruction_str)
        instructions = instructions(instruction_str)
        instructions.each do |instr|
            robot.send(instr)
        end
    end
end