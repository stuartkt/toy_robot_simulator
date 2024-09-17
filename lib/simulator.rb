require 'tty-prompt'
require_relative 'robot'

class Simulator
  COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT EXIT].freeze

  def initialize(prompt = TTY::Prompt.new(interrupt: :exit))
    @robot = Robot.new
    @prompt = prompt
  end

  def run
    loop do
      command = @prompt.select("Choose a command:",  COMMANDS)
      break if command == 'EXIT'

      if command == 'PLACE'
        args = @prompt.ask("Enter coordinates and direction (e.g., 0,0,NORTH):")
        x, y, direction = args.strip.upcase.split(',')
        @robot.place(x.to_i, y.to_i, direction)
      elsif command == 'REPORT'
        puts @robot.report
      else
        @robot.public_send(command.downcase)
      end
    end
    puts "Exiting"
  end

  def run_example
    commands = COMMANDS.reject { |cmd| cmd == 'EXIT' }
    100.times do
      command = commands.sample
      if command == 'PLACE'
        @robot.place(*generate_place_args)
      elsif command == 'REPORT'
        puts @robot.report
      else
        @robot.public_send(command.downcase)
      end
    end
    puts "Exiting"
  end

  private

  def generate_place_args
    [rand(5), rand(5), %w[NORTH EAST SOUTH WEST].sample]
  end

end