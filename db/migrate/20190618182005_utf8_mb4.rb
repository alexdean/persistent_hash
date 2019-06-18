class Utf8Mb4 < ActiveRecord::Migration[5.2]
  def change
    change_column 'persistent_hash', 'key_name', :string, limit: 191
  end
end
