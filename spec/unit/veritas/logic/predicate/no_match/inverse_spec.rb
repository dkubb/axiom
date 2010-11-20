require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch#inverse' do
  subject { no_match.inverse }

  let(:attribute) { Attribute::String.new(:name)   }
  let(:no_match)  { attribute.no_match(/Dan Kubb/) }

  it_should_behave_like 'an idempotent method'

  it { should eql(attribute.match(/Dan Kubb/)) }

  it 'is invertible' do
    subject.inverse.should equal(no_match)
  end
end
