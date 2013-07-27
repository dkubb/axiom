# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Tautology, '#and' do
  subject { object.and(other) }

  let(:other)  { double('other')          }
  let(:object) { described_class.instance }

  it { should be(other) }
end
