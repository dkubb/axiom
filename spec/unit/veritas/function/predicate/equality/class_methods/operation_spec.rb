require 'spec_helper'

describe Function::Predicate::Equality, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:==) }
end
