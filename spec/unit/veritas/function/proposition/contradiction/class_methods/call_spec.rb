# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Contradiction, '.call' do
  subject { object.call }

  let(:object) { described_class }

  it { should be(false) }
end
