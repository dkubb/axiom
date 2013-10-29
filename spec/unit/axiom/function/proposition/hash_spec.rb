# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#hash' do
  subject { object.hash }

  let(:object)          { described_class.instance         }
  let(:described_class) { Class.new(Function::Proposition) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash }
end
