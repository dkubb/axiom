require 'spec_helper'

describe 'Veritas::Logic::Proposition::False.inverse' do
  subject { Logic::Proposition::False.inverse }

  it { should equal(Logic::Proposition::True) }
end
