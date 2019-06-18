class ConvertReadableValueToText < ActiveRecord::Migration[4.2]
  def change
    change_column :persistent_hash, :readable_value, :text
  end
end
