require 'spec_helper'

describe Function::Predicate::Equality, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(object) }
end
