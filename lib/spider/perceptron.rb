module Spider
  class Perceptron
    include SingleLayerNetwork
    
    attr_reader   :learning_rate, :threshold
    attr_accessor :max_attempts # max_attempts = [0..+inf)

    # learning_rate = (0..1]
    # threshold     = [0..+inf)
    def initialize(number_of_inputs, params = {})
      super(number_of_inputs)

      @learning_rate = params[:learning_rate] || 1
      @threshold     = params[:threshold]     || 2
      @max_attempts  = 1000
      add_bias(1)
    end

    def train(vectors)
      @max_attempts.times do
        weights_changed = false

        vectors.each do |vector|
          expected_result = vector.last
          vector = vector[0..-2]

          set_values(vector)
          result = run(vector)
          
          if result != expected_result
            weights_changed = true
            adjust_weights(vector, expected_result)
          end
        end

        return unless weights_changed
      end

      raise 'Could not train the net in the specified time'
    end

    def adjust_weights(vector, result)
      vector.each_with_index do |value, index|
        @inputs[index].weight += value * result * @learning_rate
      end

      @bias.weight += result * @learning_rate
    end

    def run(vector)
      activation_value = super
      
      if    (activation_value >  @threshold)
         1
      elsif (activation_value < -@threshold)
        -1
      else #(-@threshold <= activation_value <= @threshold)
         0
      end
    end

  end
end
