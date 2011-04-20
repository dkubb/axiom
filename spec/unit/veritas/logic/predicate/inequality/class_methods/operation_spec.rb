require 'spec_helper'

describe Logic::Predicate::Inequality, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:'!=') }
end
