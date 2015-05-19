## Overview

PersistentHash provides an ActiveRecord-base key/value store which can be used
for various bits of application state which don't need dedicated models of
their own.

I've used this gem in production for storing relatively low volumes of data.
Typically it serves as a registry for configuration values and current-state
information. It may not be suitable as a high-volume key/value store.

## Usage

```ruby
# inserts a record into the database
PersistentHash['foo'] = :bar

# retrieves that record
PersistentHash['foo']
# => 'bar'
```

## Installation

```
# Gemfile
gem 'persistent_hash'

$ rake waiting_room:install:migrations
$ rake db:migrate
```

## Formatters

PersistentHash stores data in marshalled Ruby objects. Because these marshalled
objects are hard to read at a glance, the class also stores a formatted version
which is intended to be readable outside of Ruby. This is useful for inspecting
data via a SQL client or if you have a non-Ruby process (like nagios) watching
the values in this table.

```ruby
# config/initializers/persistent_hash.rb
PersistentHash::Formatter.add(Time, ->(val) {val.utc.iso8601})

PersistentHash['time'] = Time.parse('2015-05-19T00:00:00Z')
PersistentHash.where(key_name: 'time').first.readable_value
# => '2015-05-19T00:00:00Z'
```

## Why?

To minimize dependencies.

Projects I work on already have a primary database (typically mysql), and adding
an additional dedicated database (like redis) for key/value pairs increases
service dependencies for no real benefit. Mysql is perfectly capable of doing
this job on its own. PersistentHash is just a nice way of doing it.

I've got nothing against redis. (In fact, I use it every day.) I'm just very
wary of addition additional dependencies to projects when they're not absolutely
necessary.
