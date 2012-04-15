# encoding: utf-8

require 'spec_helper'

describe Comparator, '#compare' do
  subject { object.compare(*methods) }

  let(:methods)  { [ :nil?, :to_s ]                }
  let(:object)   { Class.new { extend Comparator } }
  let(:instance) { object.new                      }

  before do
    object.instance_eval { include Immutable }
  end

  it_should_behave_like 'a command method'

  it 'includes Comparator::Methods' do
    expect { subject }.to change { object.include?(Comparator::Methods) }.from(false).to(true)
  end

  it 'defines a #hash public instance method' do
    expect { subject }.to change { object.public_instance_methods(false).map(&:to_s) }.from([]).to([ 'hash' ])
  end

  it 'defines a #hash method that uses the class and declared methods' do
    # use Fixnum#eql? instead of Fixnum#equal? because the hash value may not
    # always be the same object (i.e. on JRuby), and we mostly only care that
    # the type and value match the expected Fixnum.
    subject
    instance.hash.should eql(object.hash ^ false.hash ^ instance.to_s.hash)
  end

  it 'memoizes #hash' do
    subject
    instance.hash
    instance.memoized(:hash).should_not be_nil
  end

  it 'defines a #cmp? private instance method' do
    expect { subject }.to change { object.private_instance_methods(false).map(&:to_s) }.from([]).to([ 'cmp?' ])
  end
end
