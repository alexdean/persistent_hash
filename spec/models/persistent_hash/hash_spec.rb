require 'rails_helper'

RSpec.describe PersistentHash::Hash, type: :model do

  let(:subject) { PersistentHash::Hash }

  after(:each) do
    PersistentHash::Formatter.reset!
  end

  it "should get and set string values" do
    subject['foo'] = 'bar'
    expect(subject['foo']).to eq 'bar'
  end

  it "should sanitize unsafe strings" do
    subject['foo\',\'bar\'); delete from persistent_hash;'] = 'foo'
    expect(subject['foo\',\'bar\'); delete from persistent_hash;']).to eq 'foo'
  end

  it "should overwrite existing values on assignment" do
    subject['foo'] = 'bar'
    subject['foo'] = 'baz'
    expect(subject['foo']).to eq 'baz'
  end

  it "should delete unwanted values" do
    subject['foo'] = 'bar'
    subject['foo'] = nil
    expect(subject.count).to eq 0
  end

  it "should return nil for unknown keys" do
    expect(subject['missing']).to eq nil
  end

  it "should store non-string types" do
    subject['int'] = 5
    expect(subject['int'].class).to eq Integer

    subject['time'] = Time.now
    expect(subject['time'].class).to eq Time
  end

  it "should store updated_at time" do
    now = Time.zone.now
    Timecop.freeze(now) do
      subject['foo'] = 'bar'
    end

    # to_i to fix resolution problems.
    # (now has microseconds, which get removed by passing through the db)
    expect(subject.where(key_name: 'foo').first.updated_at.to_i).to eq now.to_i

    the_past = now - 2.days
    Timecop.freeze(the_past) do
      subject['foo'] = 'bar'
    end

    expect(subject.where(key_name: 'foo').first.updated_at.to_i).to eq the_past.to_i
  end

  it "should use formatters to set readable values" do
    PersistentHash::Formatter.add(Time, ->(val) {val.utc.iso8601})

    subject['time'] = '2013-05-20T00:12:30Z'.to_time
    expect(subject.where(key_name: 'time').first.readable_value).to eq '2013-05-20T00:12:30Z'

    PersistentHash::Formatter.add(Integer, ->(val) {val.to_f})

    subject['fixnum'] = 12
    expect(subject.where(key_name: 'fixnum').first.readable_value).to eq '12.0'
  end

end
