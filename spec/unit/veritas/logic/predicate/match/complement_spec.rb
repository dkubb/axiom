require 'spec_helper'

describe 'Veritas::Logic::Predicate::Match#complement' do
  subject { match.complement }

  let(:attribute) { Attribute::String.new(:name) }
  let(:match)     { attribute.match(/Dan Kubb/)  }

  it { should eql(attribute.no_match(/Dan Kubb/)) }

  it 'is reversible' do
    subject.complement.should equal(match)
  end

  it_should_behave_like 'an idempotent method'
end
