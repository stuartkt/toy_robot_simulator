require 'spec_helper'
require_relative '../lib/simulator'
require 'tty-prompt'

RSpec.describe Simulator do
  let(:robot) { instance_double(Robot) }
  let(:prompt) { instance_double(TTY::Prompt) }
  subject(:simulator) { described_class.new(prompt) }

  before do
    allow(Robot).to receive(:new).and_return(robot)
  end

  describe '#run' do
    it 'processes commands until EXIT' do
      expect(prompt).to receive(:select).and_return('PLACE', 'MOVE', 'LEFT', 'RIGHT', 'REPORT', 'EXIT')
      expect(prompt).to receive(:ask).and_return('0,0,NORTH')

      expect(robot).to receive(:place).with(0, 0, 'NORTH')
      expect(robot).to receive(:move)
      expect(robot).to receive(:left)
      expect(robot).to receive(:right)
      expect(robot).to receive(:report).and_return('1,1,WEST')

      expect { simulator.run }.to output(/1,1,WEST\nExiting\n/).to_stdout    end
  end

  describe '#run_example' do
    before do
      allow(simulator).to receive(:generate_place_args).and_return([0, 0, 'NORTH'])
    end

    it 'executes 100 random commands' do
      expect(robot).to receive(:place).at_least(:once).with(0, 0, 'NORTH')
      expect(robot).to receive(:move).at_least(:once)
      expect(robot).to receive(:left).at_least(:once)
      expect(robot).to receive(:right).at_least(:once)
      expect(robot).to receive(:report).at_least(:once).and_return('0,0,NORTH')

      expect { simulator.run_example }.to output(/Exiting/).to_stdout
    end
  end

  describe '#generate_place_args' do
    it 'generates valid place arguments' do
      args = simulator.send(:generate_place_args)
      expect(args.size).to eq(3)
      expect(args[0]).to be_between(0, 4)
      expect(args[1]).to be_between(0, 4)
      expect(%w[NORTH EAST SOUTH WEST]).to include(args[2])
    end
  end
end