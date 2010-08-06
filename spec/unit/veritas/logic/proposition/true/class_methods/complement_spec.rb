require 'spec_helper'

describe 'Veritas::Logic::Proposition::True.complement' do
  subject { Logic::Proposition::True.complement }

  it { should equal(Logic::Proposition::False) }
end
