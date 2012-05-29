# encoding: utf-8

# Extend Time with methods to find the previous Time
class Time

  unless method_defined? :pred
    # Decrement the Time by one second
    #
    # @example
    #   previous_second = time.pred
    #
    # @return [Time]
    #
    # @api public
    def pred
      self - 1
    end
  end

end # class Time
