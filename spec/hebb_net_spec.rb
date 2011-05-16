require 'spec_helper'

describe HebbNet do

  before :each do
    @net = HebbNet.new(2)
    #this trainning data models a logical AND
    @vectors = [[ 1,  1,  1],
                [ 1, -1, -1],
                [-1,  1, -1],
                [-1, -1, -1]]
  end

  it "creates as many neurons as needed" do
    @net = HebbNet.new(3)
    @net.inputs.count.should == 3
    @net.target.inputs.count.should == 3
  end

  it "initializes all neurons as 0 weight neurons" do
    @net.inputs.first.weight.should == 0
  end

  it "trains the network with the provided data" do
    @net.add_bias(1)
    @net.train(@vectors)

    @net.inputs.first.weight.should == 2
    @net.inputs.last.weight.should == 2
    @net.bias.weight.should == -2
  end

  it "returns correct results after being trained" do
    @net.add_bias(1)
    @net.train(@vectors)

    @net.run([ 1,  1]).should == 2
    @net.run([ 1, -1]).should == -2
    @net.run([-1, -1]).should == -6
  end

end
