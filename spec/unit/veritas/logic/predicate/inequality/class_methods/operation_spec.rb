require 'spec_helper'

describe Logic::Predicate::Inequality, '.operation' do
  subject { object.operation }

  let(:object) { Logic::Predicate::Inequality }

  it { should be(:'!=') }
end
