# encoding: utf-8

require 'spec_helper'

describe Attribute::Numeric, '#hash' do
  subject { object.hash }

  let(:object)   { described_class.new(name, options) }
  let(:name)     { :name                              }
  let(:options)  { { required: required, size: size } }
  let(:required) { true                               }
  let(:size)     { 0..10                              }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ name.hash ^ object.type.hash ^ required.hash }
end
