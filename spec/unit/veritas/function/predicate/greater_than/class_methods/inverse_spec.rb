require 'spec_helper'

describe Function::Predicate::GreaterThan, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::LessThanOrEqualTo) }
end
