# encoding: utf-8

# Extend Date with methods to find the previous Date
class Date

  unless method_defined? :pred
    # Decrement the Date by one day
    #
    # @example
    #   previous_day = date.pred
    #
    # @return [Date]
    #
    # @api public
    def pred
      self - 1
    end
  end

end # class Date
