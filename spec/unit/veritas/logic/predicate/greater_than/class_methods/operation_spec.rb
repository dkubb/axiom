require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::GreaterThan }

  it { should be(:>) }
end
