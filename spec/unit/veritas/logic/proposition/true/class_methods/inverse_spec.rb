require 'spec_helper'

describe Logic::Proposition::True, '.inverse' do
  subject { object.inverse }

  let(:object) { Logic::Proposition::True }

  it { should equal(Logic::Proposition::False) }
end
