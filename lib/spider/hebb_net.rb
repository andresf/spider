module Spider
  class HebbNet
    
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

    #receives an array or arrays with training data
    def train(vectors)
      vectors.each do |vector|
        expected_result = vector.slice!(-1)
        set_values(vector)
        adjust_weights(vector, expected_result)
      end
    end

    #receives an array with input data
    def run(vector)
      set_values(vector)
      @target.activation_value
    end

    def set_values(vector)
      vector.each_with_index do |value, index|
        @inputs[index].value = value
      end
    end

    def adjust_weights(vector, result)
      vector.each_with_index do |value, index|
        @inputs[index].weight += @inputs[index].value * result
      end
      
      @bias.weight += result if @bias
    end

  end
end
