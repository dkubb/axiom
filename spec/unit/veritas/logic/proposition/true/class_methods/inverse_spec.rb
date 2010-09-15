require 'spec_helper'

describe 'Veritas::Logic::Proposition::True.inverse' do
  subject { Logic::Proposition::True.inverse }

  it { should equal(Logic::Proposition::False) }
end
