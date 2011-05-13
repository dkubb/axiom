# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Contradiction, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.instance }

  it { should == 'false' }
end
