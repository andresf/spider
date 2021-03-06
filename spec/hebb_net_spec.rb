require 'spec_helper'

describe HebbNet do

  let(:net)     { HebbNet.new(2) }
  let(:vectors) { [[ 1,  1,  1],
                   [ 1, -1, -1],
                   [-1,  1, -1],
                   [-1, -1, -1]] }

  it "trains the network with the provided data" do
    net.add_bias(1)
    net.train(vectors)

    net.inputs.first.weight.should ==  2
    net.inputs.last.weight.should  ==  2
    net.bias.weight.should         == -2
  end

  it "returns correct results after being trained" do
    net.add_bias(1)
    net.train(vectors)

    net.run([ 1,  1]).should ==  2
    net.run([ 1, -1]).should == -2
    net.run([-1,  1]).should == -2
    net.run([-1, -1]).should == -6
  end

end
