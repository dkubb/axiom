require 'spec_helper'

describe Logic::Proposition::False, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Proposition::False }

  it { should equal(Logic::Proposition::True) }
end
