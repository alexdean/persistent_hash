class CreatePersistentHash < ActiveRecord::Migration[4.2]
  def change
    create_table :persistent_hash do |t|
      t.string   :key_name, null: false
      t.string   :readable_value, null: false
      t.text     :marshalled, null: false
      t.datetime :updated_at, null: false
    end

    add_index :persistent_hash, :key_name, unique: true, name: 'persistent_hash_uniq'
  end
end
