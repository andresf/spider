module Spider
  class Perceptron < SingleLayerNetwork
    
    attr_reader :learning_rate, :threshold, :max_attempts

    # learning_rate = (0..1]
    # threshold     = [0..+inf)
    def initialize(number_of_inputs, learning_rate = 1, threshold = 2)
      super(number_of_inputs)

      @learning_rate = learning_rate
      @threshold = threshold
      @max_attempts = 1000
      add_bias(1)
    end

    # attempts = [0..+inf)
    def max_attempts(attempts)
      @max_attempts = attempts
    end

    def train(vectors)
      attempts = 0

      begin
        raise 'Could not train the net in the specified time' if 
          attempts > @max_attempts
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
        
        attempts += 1
      end while(weights_changed)
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
