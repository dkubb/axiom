require 'spec_helper'

describe Function::Predicate::Match, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::NoMatch) }
end
