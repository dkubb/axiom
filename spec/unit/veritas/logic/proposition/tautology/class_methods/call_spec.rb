require 'spec_helper'

describe Logic::Proposition::Tautology, '.call' do
  subject { object.call }

  let(:object) { described_class }

  it { should be(true) }
end
