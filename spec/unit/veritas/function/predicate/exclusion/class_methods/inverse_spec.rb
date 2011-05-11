require 'spec_helper'

describe Function::Predicate::Exclusion, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::Inclusion) }
end
