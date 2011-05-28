require 'spec_helper'

describe Perceptron do

  let(:net)     { Perceptron.new(2, :learning_rate => 1, :threshold =>  0) }
  let(:vectors) { [[ 1,  1,  1],
                   [ 1, -1, -1],
                   [-1,  1, -1],
                   [-1, -1, -1]] }

  it "trains the network with the provided data" do
    net.train(vectors)

    net.inputs.first.weight.should ==  1
    net.inputs.last.weight.should  ==  1
    net.bias.weight.should         == -1
  end

  it "returns correct results after being trained" do
    net.train(vectors)

    net.run([ 1,  1]).should ==  1
    net.run([ 1, -1]).should == -1
    net.run([-1,  1]).should == -1
    net.run([-1, -1]).should == -1
  end

  it "raises an exception if not able to train in X passes" do
    net.add_bias(0)
    lambda { train(vectors) }.should raise_error
  end

end
