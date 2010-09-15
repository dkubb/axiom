require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan#inverse' do
  subject { less_than.inverse }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:less_than) { attribute.lt(1)             }

  it { should eql(attribute.gte(1)) }

  it 'is invertible' do
    subject.inverse.should equal(less_than)
  end

  it_should_behave_like 'an idempotent method'
end
