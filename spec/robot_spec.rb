require 'spec_helper'
require_relative '../lib/robot'

RSpec.describe Robot do
  subject(:robot) { described_class.new }

  describe '#place' do
    it 'places the robot on the table' do
      robot.place(0, 0, 'NORTH')
      expect(robot.report).to eq('0,0,NORTH')
    end

    it 'does not place the robot outside the table' do
      robot.place(5, 5, 'NORTH')
      expect(robot.report).to eq('Robot not placed yet')
    end
  end

  describe '#move' do
    it 'moves the robot one unit forward in the face direction' do
      robot.place(0, 0, 'NORTH')
      robot.move
      expect(robot.report).to eq('0,1,NORTH')
    end

    it 'does not move the robot off the table' do
      robot.place(0, 4, 'NORTH')
      robot.move
      expect(robot.report).to eq('0,4,NORTH')
    end
  end

  describe '#left' do
    it 'rotates the robot 90 degrees left' do
      robot.place(0, 0, 'NORTH')
      robot.left
      expect(robot.report).to eq('0,0,WEST')
    end
  end

  describe '#right' do
    it 'rotates the robot 90 degrees right' do
      robot.place(0, 0, 'NORTH')
      robot.right
      expect(robot.report).to eq('0,0,EAST')
    end
  end

  describe '#report' do
    it 'returns the current position and direction of the robot' do
      robot.place(1, 2, 'EAST')
      expect(robot.report).to eq('1,2,EAST')
    end

    it 'returns a message if the robot is not placed' do
      expect(robot.report).to eq('Robot not placed yet')
    end
  end
end