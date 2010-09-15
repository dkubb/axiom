require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion#inverse' do
  subject { exclusion.inverse }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:exclusion) { attribute.exclude([ 1 ])    }

  it { should eql(attribute.include([ 1 ])) }

  it 'is invertible' do
    subject.inverse.should equal(exclusion)
  end

  it_should_behave_like 'an idempotent method'
end
