PersistentHash::Formatter.add(
  ActiveSupport::TimeWithZone,
  ->(val) { val.iso8601 }
)

PersistentHash::Formatter.add(
  Time,
  ->(val) { val.iso8601 }
)
