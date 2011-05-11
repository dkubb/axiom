require 'spec_helper'

describe Function::Predicate::LessThan, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::GreaterThan) }
end
