module PersistentHash
  class Hash < ActiveRecord::Base
    self.table_name = 'persistent_hash'

    # save a value in the hash
    def self.[]=(key_name, value)
      item = where(key_name: key_name)
             .lock
             .first_or_initialize

      if value.nil?
        item.destroy
      else
        formatted = PersistentHash::Formatter.format(value)
        item.update_attributes(
          readable_value: formatted,
          marshalled: Base64.encode64(Marshal.dump(value))
        )
      end
    end

    # fetch a value from the hash.
    #
    # @return The requested value, or nil if the requested key does not exist.
    def self.[](key_name)
      value = nil
      item = select(:marshalled).where(key_name: key_name).first
      if item
        value = Marshal.load(Base64.decode64(item.marshalled))
      end

      value
    end
  end
end
