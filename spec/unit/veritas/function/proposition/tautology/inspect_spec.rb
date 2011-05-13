# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Tautology, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.instance }

  it { should == 'true' }
end
