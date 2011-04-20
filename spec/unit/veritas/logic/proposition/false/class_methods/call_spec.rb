require 'spec_helper'

describe Logic::Proposition::False, '.call' do
  subject { object.call }

  let(:object) { described_class }

  it { should be(false) }
end
