unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'spider/single_layer_network'
require_relative 'spider/hebb_net'
require_relative 'spider/neuron'

module Spider
end
