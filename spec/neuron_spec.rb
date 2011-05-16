require 'spec_helper'

describe Neuron do
  
  before :each do
    @neuron1 = Neuron.new(1)
    @neuron2 = Neuron.new(1)
  end

  it "adds an input neuron" do
    @neuron1.add_input(@neuron2)

    @neuron1.inputs.include?(@neuron2).should be_true
    @neuron2.outputs.include?(@neuron1).should be_true
  end

  it "adds an output neuron" do
    @neuron2.add_output(@neuron1)

    @neuron1.inputs.include?(@neuron2).should be_true
    @neuron2.outputs.include?(@neuron1).should be_true
  end

  it "returns the preset value (* weight) if there are no input neurons" do
    @neuron1.value = 1
    @neuron1.weight = 2
    @neuron1.activation_value.should == 2
  end

  it "raises an error if there is no value to return" do
    lambda { @neuron1.activation_value }.should raise_error
  end

  it "returns the sum of the inputs as the value if input neurons are present" do
    @neuron1.add_input(@neuron2)
    @neuron2.value = 1
    
    @neuron1.activation_value.should == 1
  end

end
