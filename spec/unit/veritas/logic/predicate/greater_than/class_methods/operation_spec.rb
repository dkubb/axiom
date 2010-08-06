require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan.operation' do
  subject { Logic::Predicate::GreaterThan.operation }

  it { should be(:>) }
end
