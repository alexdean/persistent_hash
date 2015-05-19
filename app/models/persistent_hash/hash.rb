module PersistentHash
  class Hash < ActiveRecord::Base

    self.table_name = 'persistent_hash'

    def self.[]=(key_name, value)
      if value.nil?
        where(key_name: key_name).delete_all
        nil
      else
        formatted = PersistentHash::Formatter.format(value)

        sql = <<-EOF
        REPLACE INTO #{self.table_name}
        SET
          key_name       = #{sanitize(key_name)},
          readable_value = #{sanitize(formatted)},
          marshalled     = '#{Base64.encode64(Marshal.dump(value))}',
          updated_at     = '#{Time.zone.now.to_s(:db)}'
        EOF
        connection.execute(sql)
      end
    end

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
