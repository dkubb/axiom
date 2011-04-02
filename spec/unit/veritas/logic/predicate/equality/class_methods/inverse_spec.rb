require 'spec_helper'

describe Logic::Predicate::Equality, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Predicate::Equality }

  it { should equal(Logic::Predicate::Inequality) }
end
