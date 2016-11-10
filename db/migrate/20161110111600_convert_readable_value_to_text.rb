class ConvertReadableValueToText < ActiveRecord::Migration
  def change
    change_column :persistent_hash, :readable_value, :text
  end
end
