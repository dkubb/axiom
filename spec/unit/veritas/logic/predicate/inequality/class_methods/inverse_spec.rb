require 'spec_helper'

describe Logic::Predicate::Inequality, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::Inequality }

  it { should equal(Logic::Predicate::Equality) }
end
