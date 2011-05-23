module Spider
  class HebbNet < SingleLayerNetwork
    
    attr_reader :inputs, :target, :bias

    #receives an array or arrays with training data
    def train(vectors)
      vectors.each do |vector|
        expected_result = vector.slice!(-1)
        set_values(vector)
        adjust_weights(vector, expected_result)
      end
    end

    def adjust_weights(vector, result)
      vector.each_with_index do |value, index|
        @inputs[index].weight += value * result
      end
      
      @bias.weight += result if @bias
    end

  end
end
