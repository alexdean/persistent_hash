module PersistentHash

  # Formatters are used to create the readable_value attribute for values
  # stored in the Hash.
  class Formatter

    @formatters = {}

    # specify how the human-readable version of the item should be generated
    #
    # @example
    #   PersistentHash::Formatter.add(
    #     Time,
    #     ->(val) { val.iso8601 }
    #   )
    #
    # @param [Class] clazz The formatter will receive instances of this class.
    # @param [Proc]  proc  A proc which receives an instance of clazz and
    #                      returns a string representation of that instance.
    def self.add(clazz, proc)
      @formatters[clazz] = proc
      true
    end

    # create a human-readable version of value for storage in the db
    #
    # If a specific formattation proc has been supplied for the value's
    # class via `add`, that proc will be invoked. Otherwise, the result of
    # the value's `to_s` method will be returned.
    #
    # @return [String] A string representation of value.
    def self.format(value)
      formatter = @formatters[value.class]
      if formatter
        formatted = formatter.call(value)
      else
        formatted = value.to_s
      end
    end

    # forget all current formatters
    def reset!
      @formatters = {}
      true
    end

  end
end
