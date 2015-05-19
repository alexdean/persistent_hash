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
# => :bar
```

Stored objects are [marshalled](http://ruby-doc.org/core-2.2.2/Marshal.html) for
storage, and unmarshalled on retrieval.

This means:

  - you can store most Ruby objects
  - storage is not necessarily portable across Ruby versions

Read more about the [Marshal](http://ruby-doc.org/core-2.2.2/Marshal.html)
module to understand the limitations of this approach.

## Installation

```ruby
# Gemfile
gem 'persistent_hash'
```

```
$ rake persistent_hash:install:migrations
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
PersistentHash::Formatter.add(Fixnum, ->(val) { "This Fixnum is #{val}."})

PersistentHash['number'] = 5

PersistentHash::Hash.where(key_name: 'number').first.readable_value
# => "This Fixnum is 5."
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
