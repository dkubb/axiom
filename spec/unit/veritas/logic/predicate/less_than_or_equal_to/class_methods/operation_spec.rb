require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::LessThanOrEqualTo }

  it { should be(:<=) }
end
