require 'spec_helper'

describe Logic::Predicate::GreaterThanOrEqualTo, '.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::GreaterThanOrEqualTo }

  it { should be(:>=) }
end
