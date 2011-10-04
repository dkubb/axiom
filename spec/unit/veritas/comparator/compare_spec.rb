# encoding: utf-8

require 'spec_helper'

describe Comparator, '#compare' do
  subject { object.compare(*methods) }

  let(:methods)  { [ :object_id, :to_s ]           }
  let(:object)   { Class.new { extend Comparator } }
  let(:instance) { object.new                      }

  before do
    object.instance_eval { include Immutable }
  end

  it { should equal(object) }

  it 'includes Comparator::Methods' do
    expect { subject }.to change { object.include?(Comparator::Methods) }.from(false).to(true)
  end

  it 'defines a #hash public instance method' do
    expect { subject }.to change { object.public_instance_methods(false).map(&:to_s) }.from([]).to([ 'hash' ])
  end

  it 'defines a #hash method that uses the class and declared methods' do
    subject
    instance.hash.should equal(object.hash ^ instance.object_id.hash ^ instance.to_s.hash)
  end

  # XXX: temporary to see why travis-ci is failing for the spec above
  it { instance.class.should equal(object) }
  it { instance.class.hash.should equal(object.hash) }

  it 'memoizes #hash' do
    subject
    instance.hash
    instance.memoized(:hash).should_not be_nil
  end

  it 'defines a #cmp? private instance method' do
    expect { subject }.to change { object.private_instance_methods(false).map(&:to_s) }.from([]).to([ 'cmp?' ])
  end
end
