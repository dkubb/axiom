require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion#inverse' do
  subject { inclusion.inverse }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:inclusion) { attribute.include([ 1 ])    }

  it_should_behave_like 'an idempotent method'

  it { should eql(attribute.exclude([ 1 ])) }

  it 'is invertible' do
    subject.inverse.should equal(inclusion)
  end
end
