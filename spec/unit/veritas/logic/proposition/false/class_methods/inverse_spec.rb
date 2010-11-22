require 'spec_helper'

describe 'Veritas::Logic::Proposition::False.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Proposition::False }

  it { should equal(Logic::Proposition::True) }
end
