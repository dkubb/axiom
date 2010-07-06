require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch#complement' do
  subject { no_match.complement }

  let(:attribute) { Attribute::String.new(:name)   }
  let(:no_match)  { attribute.no_match(/Dan Kubb/) }

  it { should eql(attribute.match(/Dan Kubb/)) }

  it 'is reversible' do
    subject.complement.should equal(no_match)
  end

  it_should_behave_like 'an idempotent method'
end
