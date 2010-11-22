require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::Inequality }

  it { should be(:'!=') }
end
