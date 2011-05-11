require 'spec_helper'

describe Function::Predicate::Inclusion, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::Exclusion) }
end
