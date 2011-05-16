module Spider
  class Neuron
    
    attr_accessor :weight, :value
    attr_reader :inputs, :outputs

    def initialize(weight, value = nil)
      @inputs  = []
      @outputs = []
      
      @weight = weight
      @value  = value
    end

    def add_input(neuron)
      @value = nil
      
      unless @inputs.include?(neuron)
        @inputs << neuron
      end

      unless neuron.outputs.include?(self)
        neuron.add_output(self)
      end
    end

    def add_output(neuron)
      unless @outputs.include?(neuron)
        @outputs << neuron
      end
      
      unless neuron.inputs.include?(self)
        neuron.add_input(self)
      end
    end

    def activation_value
      return @value * @weight if @value
      return @inputs.inject(0) { |result, input| 
        result += input.activation_value } if !@inputs.empty?

      raise "Neuron #{self} has no preset value nor it has input neurons."
    end

  end
end
