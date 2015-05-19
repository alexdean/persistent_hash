Rails.application.routes.draw do

  mount PersistentHash::Engine => "/persistent_hash"
end
