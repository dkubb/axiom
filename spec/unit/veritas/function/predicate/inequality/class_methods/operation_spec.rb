require 'spec_helper'

describe Function::Predicate::Inequality, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:'!=') }
end
