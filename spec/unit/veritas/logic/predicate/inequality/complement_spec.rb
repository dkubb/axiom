require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality#complement' do
  subject { inequality.complement }

  let(:attribute)  { Attribute::Integer.new(:id) }
  let(:inequality) { attribute.ne(1)             }

  it { should eql(attribute.eq(1)) }

  it 'is reversible' do
    subject.complement.should eql(inequality)
  end

  it_should_behave_like 'an idempotent method'
end
