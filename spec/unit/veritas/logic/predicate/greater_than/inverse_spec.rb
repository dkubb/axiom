require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan#inverse' do
  subject { greater_than.inverse }

  let(:attribute)    { Attribute::Integer.new(:id) }
  let(:greater_than) { attribute.gt(1)             }

  it_should_behave_like 'an idempotent method'

  it { should eql(attribute.lte(1)) }

  it 'is invertible' do
    subject.inverse.should equal(greater_than)
  end
end
