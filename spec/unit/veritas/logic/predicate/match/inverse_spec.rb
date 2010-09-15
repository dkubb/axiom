require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match#inverse' do
  subject { match.inverse }

  let(:attribute) { Attribute::String.new(:name) }
  let(:match)     { attribute.match(/Dan Kubb/)  }

  it { should eql(attribute.no_match(/Dan Kubb/)) }

  it 'is invertible' do
    subject.inverse.should equal(match)
  end

  it_should_behave_like 'an idempotent method'
end
