module Spider
  module SingleLayerNetwork

    attr_reader :inputs, :target, :bias

    def initialize(number_of_inputs)
      @inputs = []
      number_of_inputs.times { @inputs << Neuron.new(0) }

      @target = Neuron.new(0)
      @inputs.each { |input| @target.add_input(input) }
    end

    def add_bias(value)
      @bias ||= Neuron.new(0)
      @bias.value = value
      @target.add_input(@bias)
    end

    def run(vector)
      set_values(vector)
      @target.activation_value
    end

    def set_values(vector)
      vector.each_with_index do |value, index|
        @inputs[index].value = value
      end
    end

    def current_weights
      weights = @inputs.map { |input| input.weight }
      weights << @bias.weight if @bias
      weights
    end

  end
end
