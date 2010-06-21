require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan#complement' do
  subject { less_than.complement }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:less_than) { attribute.lt(1)             }

  it { should eql(attribute.gte(1)) }

  it 'is reversible' do
    subject.complement.should eql(less_than)
  end

  it_should_behave_like 'an idempotent method'
end
