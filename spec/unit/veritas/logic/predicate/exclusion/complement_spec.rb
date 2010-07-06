require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion#complement' do
  subject { exclusion.complement }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:exclusion) { attribute.exclude([ 1 ])    }

  it { should eql(attribute.include([ 1 ])) }

  it 'is reversible' do
    subject.complement.should equal(exclusion)
  end

  it_should_behave_like 'an idempotent method'
end
