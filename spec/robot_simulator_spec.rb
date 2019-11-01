
require_relative("../lib/robot_simulator")
RSpec.describe Robot do
  attr_reader(:robot)
  before do 
    @robot = Robot.new
  end
  it 'Tests robot bearing' do
    [:east, :west, :north, :south].each do |direction|
      robot.orient(direction)
      expect(robot.bearing).to(eq(direction))
    end
  end
  it 'Tests invalid robot bearing' do
    expect { robot.orient(:crood) }.to(raise_error(ArgumentError))
  end
  it 'Tests turn right from north' do
    robot.orient(:north)
    robot.turn_right
    expect(robot.bearing).to(eq(:east))
  end
  it 'Tests turn right from east' do
    robot.orient(:east)
    robot.turn_right
    expect(robot.bearing).to(eq(:south))
  end
  it 'Tests turn right from south' do
    robot.orient(:south)
    robot.turn_right
    expect(robot.bearing).to(eq(:west))
  end
  it 'Tests turn right from west' do
    robot.orient(:west)
    robot.turn_right
    expect(robot.bearing).to(eq(:north))
  end
  it 'Tests turn left from north' do
    robot.orient(:north)
    robot.turn_left
    expect(robot.bearing).to(eq(:west))
  end
  it 'Tests turn left from east' do
    robot.orient(:east)
    robot.turn_left
    expect(robot.bearing).to(eq(:north))
  end
  it 'Tests turn left from south' do
    robot.orient(:south)
    robot.turn_left
    expect(robot.bearing).to(eq(:east))
  end
  it 'Tests turn left from west' do
    robot.orient(:west)
    robot.turn_left
    expect(robot.bearing).to(eq(:south))
  end
  it 'Tests robot coordinates' do
    robot.at(3, 0)
    expect(robot.coordinates).to(eq([3, 0]))
  end
  it 'Tests other robot coordinates' do
    robot.at(-2, 5)
    expect(robot.coordinates).to(eq([-2, 5]))
  end
  it 'Tests advance when facing north' do
    robot.at(0, 0)
    robot.orient(:north)
    robot.advance
    expect(robot.coordinates).to(eq([0, 1]))
  end
  it 'Tests advance when facing east' do
    robot.at(0, 0)
    robot.orient(:east)
    robot.advance
    expect(robot.coordinates).to(eq([1, 0]))
  end
  it 'Tests advance when facing south' do
    robot.at(0, 0)
    robot.orient(:south)
    robot.advance
    expect(robot.coordinates).to(eq([0, -1]))
  end
  it 'Tests advance when facing west' do
    robot.at(0, 0)
    robot.orient(:west)
    robot.advance
    expect(robot.coordinates).to(eq([-1, 0]))
  end
end
RSpec.describe Simulator do
  def simulator
    @simulator ||= Simulator.new
  end
  it 'Tests instructions for turning left' do
    expect(simulator.instructions("L")).to(eq([:turn_left]))
  end
  it 'Tests instructions for turning right' do
    expect(simulator.instructions("R")).to(eq([:turn_right]))
  end
  it 'Tests instructions for advancing' do
    expect(simulator.instructions("A")).to(eq([:advance]))
  end
  it 'Tests series of instructions' do
    commands = [:turn_right, :advance, :advance, :turn_left]
    expect(simulator.instructions("RAAL")).to(eq(commands))
  end
  it 'Tests instruct robot' do
    robot = Robot.new
    simulator.place(robot, :x => -2, :y => 1, :direction => :east)
    simulator.evaluate(robot, "RLAALAL")
    expect(robot.coordinates).to(eq([0, 2]))
    expect(robot.bearing).to(eq(:west))
  end
  it 'Tests instruct many robots' do
    robot1 = Robot.new
    robot2 = Robot.new
    robot3 = Robot.new
    simulator.place(robot1, :x => 0, :y => 0, :direction => :north)
    simulator.place(robot2, :x => 2, :y => -7, :direction => :east)
    simulator.place(robot3, :x => 8, :y => 4, :direction => :south)
    simulator.evaluate(robot1, "LAAARALA")
    simulator.evaluate(robot2, "RRAAAAALA")
    simulator.evaluate(robot3, "LAAARRRALLLL")
    expect(robot1.coordinates).to(eq([-4, 1]))
    expect(robot1.bearing).to(eq(:west))
    expect(robot2.coordinates).to(eq([-3, -8]))
    expect(robot2.bearing).to(eq(:south))
    expect(robot3.coordinates).to(eq([11, 5]))
    expect(robot3.bearing).to(eq(:north))
  end
end
