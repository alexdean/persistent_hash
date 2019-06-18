class ConvertReadableValueToText < ActiveRecord::Migration[5.0]
  def change
    change_column :persistent_hash, :readable_value, :text
  end
end
