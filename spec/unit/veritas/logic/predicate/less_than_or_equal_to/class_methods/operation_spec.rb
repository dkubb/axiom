require 'spec_helper'

describe Logic::Predicate::LessThanOrEqualTo, '.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::LessThanOrEqualTo }

  it { should be(:<=) }
end
