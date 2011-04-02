require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate, '#inverse' do
  subject { object.inverse }

  let(:described_class) { Class.new(PredicateSpecs::Object) }
  let(:attribute)       { Attribute::Integer.new(:id)       }
  let(:object)          { described_class.new(attribute, 1) }

  before do
    described_class.class_eval do
      def inspect
        "#{left.inspect} op #{right.inspect}"
      end
    end
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(described_class) }

  it { should_not equal(object) }

  its(:left)  { should equal(attribute) }
  its(:right) { should == 1             }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
