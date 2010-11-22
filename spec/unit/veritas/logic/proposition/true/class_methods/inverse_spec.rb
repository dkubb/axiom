require 'spec_helper'

describe 'Veritas::Logic::Proposition::True.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Proposition::True }

  it { should equal(Logic::Proposition::False) }
end
