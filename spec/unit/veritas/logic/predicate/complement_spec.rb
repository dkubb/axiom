require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#complement' do
  subject { predicate.complement }

  let(:klass)     { Class.new(PredicateSpecs::Object)        }
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:predicate) { klass.new(attribute, 1) }

  before do
    klass.class_eval do
      def inspect
        "#{left.inspect} op #{right.inspect}"
      end
    end
  end

  it { should be_kind_of(klass) }

  it { should_not equal(predicate) }

  its(:left)  { should equal(attribute) }
  its(:right) { should == 1             }

  it 'is reversible' do
    subject.complement.should equal(predicate)
  end

  it_should_behave_like 'an idempotent method'
end
