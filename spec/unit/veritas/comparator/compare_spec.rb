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

  it { should equal(object) }

  it 'includes Comparator::Methods' do
    expect { subject }.to change { object.include?(Comparator::Methods) }.from(false).to(true)
  end

  it 'defines a #hash public instance method' do
    expect { subject }.to change { object.public_instance_methods(false).map(&:to_s) }.from([]).to([ 'hash' ])
  end

  if RUBY_ENGINE == 'jruby' && JRUBY_VERSION <= '1.6.4' && RUBY_VERSION == '1.9.2'
    it 'defines a #hash method that uses the class and declared methods' do
      subject
      instance.hash.should eql(object.hash ^ false.hash ^ instance.to_s.hash)
    end
  else
    it 'defines a #hash method that uses the class and declared methods' do
      subject
      instance.hash.should equal(object.hash ^ false.hash ^ instance.to_s.hash)
    end
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
