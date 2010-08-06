require 'spec_helper'

describe 'Veritas::Logic::Proposition::False.complement' do
  subject { Logic::Proposition::False.complement }

  it { should equal(Logic::Proposition::True) }
end
