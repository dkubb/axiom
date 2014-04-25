# encoding: utf-8

require 'spec_helper'

describe Function::String::Length::Methods, '#length' do
  subject { object.length }

  let(:described_class) { Class.new { include Function::String::Length::Methods } }
  let(:object)          { described_class.new.freeze                              }

  it { should be_instance_of(Function::String::Length) }

  its(:operand) { should be(object) }
end
