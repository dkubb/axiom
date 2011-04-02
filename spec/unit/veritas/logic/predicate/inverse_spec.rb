require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate, '#inverse' do
  subject { object.inverse }

  let(:klass)     { Class.new(PredicateSpecs::Object) }
  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:object)    { klass.new(attribute, 1)           }

  before do
    klass.class_eval do
      def inspect
        "#{left.inspect} op #{right.inspect}"
      end
    end
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(klass) }

  it { should_not equal(object) }

  its(:left)  { should equal(attribute) }
  its(:right) { should == 1             }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
