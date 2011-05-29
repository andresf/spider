module Spider
  class Neuron
    
    attr_accessor :weight, :value
    attr_reader :inputs, :outputs

    def initialize(weight, value = nil)
      @inputs  = []
      @outputs = []
      
      @weight  = weight
      @value   = value
    end

    def add_input(neuron)
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
      if @inputs.size > 0
        return @inputs.inject(0) { |r, input| r + input.activation_value }
      elsif @value
        return @value * @weight
      else
        raise "Neuron #{self} has no preset value nor input neurons."
      end
    end

  end
end
