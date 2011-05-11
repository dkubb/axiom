require 'spec_helper'

describe Function::Predicate::NoMatch, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::Match) }
end
