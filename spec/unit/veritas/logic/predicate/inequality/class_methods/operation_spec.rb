require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.operation' do
  subject { Logic::Predicate::Inequality.operation }

  it { should be(:'!=') }
end
