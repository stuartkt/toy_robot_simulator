# Toy Robot Simulator

## Description

The Toy Robot Simulator is a Ruby application that simulates a toy robot moving on a square tabletop of dimensions 5 units x 5 units.

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/stuartkt/toy-robot-simulator.git
   cd toy-robot-simulator
   ```
2. Install the required gems:
   ```
   bundle install
   ```

## Usage

#### To run the Toy Robot Simulator:

```
bin/toy_robot
```
or 
```
ruby -r ./lib/simulator.rb -e "Simulator.new.run"
```
#### To exit the Toy Robot Simulator:

```
Select EXIT or Ctrl-c
```

## Example Simulation

The `run_example` method in the `Simulator` class demonstrates a sample run of 100 random commands. To execute this example:

```
bin/toy_robot_example
```
or
```
ruby -r ./lib/simulator.rb -e "Simulator.new.run_example"
```

## Running Tests

To run the tests:

```
bundle exec rspec
```