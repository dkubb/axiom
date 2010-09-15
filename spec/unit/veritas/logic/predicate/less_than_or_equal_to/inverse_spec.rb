require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#inverse' do
  subject { less_than_or_equal_to.inverse }

  let(:attribute)             { Attribute::Integer.new(:id) }
  let(:less_than_or_equal_to) { attribute.lte(1)            }

  it { should eql(attribute.gt(1)) }

  it 'is invertible' do
    subject.inverse.should equal(less_than_or_equal_to)
  end

  it_should_behave_like 'an idempotent method'
end
