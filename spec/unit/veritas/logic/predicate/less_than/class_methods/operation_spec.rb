require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan.operation' do
  subject { Logic::Predicate::LessThan.operation }

  it { should be(:<) }
end
