require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion#complement' do
  subject { inclusion.complement }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:inclusion) { attribute.include([ 1 ])    }

  it { should eql(attribute.exclude([ 1 ])) }

  it 'is reversible' do
    subject.complement.should equal(inclusion)
  end

  it_should_behave_like 'an idempotent method'
end
