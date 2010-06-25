require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#complement' do
  subject { less_than_or_equal_to.complement }

  let(:attribute)             { Attribute::Integer.new(:id) }
  let(:less_than_or_equal_to) { attribute.lte(1)            }

  it { should eql(attribute.gt(1)) }

  it 'is reversible' do
    subject.complement.should equal(less_than_or_equal_to)
  end

  it_should_behave_like 'an idempotent method'
end
