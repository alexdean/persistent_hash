require "persistent_hash/engine"

module PersistentHash
  def self.[]=(key_name, value)
    PersistentHash::Hash[key_name] = value
  end
  def self.[](key_name)
    PersistentHash::Hash[key_name]
  end
  def self.delete(key_name)
    PersistentHash::Hash.delete(key_name)
  end
end
