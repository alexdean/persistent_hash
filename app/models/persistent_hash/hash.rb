module PersistentHash
  class Hash < ActiveRecord::Base

    self.table_name = 'persistent_hash'

    # save a value in the hash
    def self.[]=(key_name, value)
      transaction do
        where(key_name: key_name).delete_all

        if ! value.nil?
          formatted = PersistentHash::Formatter.format(value)

          create!(
            key_name: key_name,
            readable_value: formatted,
            marshalled: Base64.encode64(Marshal.dump(value))
          )
        end
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
