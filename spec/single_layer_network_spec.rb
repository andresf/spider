require 'spec_helper'

describe SingleLayerNetwork do

  let(:net)     { TestNet.new(2) }
  let(:vectors) { [[ 1,  1,  1],
                   [ 1, -1, -1],
                   [-1,  1, -1],
                   [-1, -1, -1]] }

  it "creates as many neurons as needed" do
    net.inputs.count.should        == 2
    net.target.inputs.count.should == 2
  end

  it "initializes all neurons as 0 weight neurons" do
    net.inputs.first.weight.should == 0
  end

  it "adds a bias correctly" do
    net.add_bias(1)
    net.bias.value.should == 1
    net.target.inputs.include?(net.bias).should be_true
  end

  it "returns the target neuron activation value as the result of running" do
    net.run(vectors.first[0..-2]).should == net.target.activation_value
  end

  it "returns an array with the current weights in order" do
    net.current_weights.should == [0,0]
    net.add_bias(1)
    net.current_weights.should == [0,0,0]
  end

  it "blows up if #train is not implemented" do
    lambda { net.train }.should raise_error
  end

  it "blows up if #adjust_weights is not implemented" do
    lambda { net.adjust_weights }.should raise_error
  end

end
