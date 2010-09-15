require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality#inverse' do
  subject { inequality.inverse }

  let(:attribute)  { Attribute::Integer.new(:id) }
  let(:inequality) { attribute.ne(1)             }

  it { should eql(attribute.eq(1)) }

  it 'is invertible' do
    subject.inverse.should equal(inequality)
  end

  it_should_behave_like 'an idempotent method'
end
