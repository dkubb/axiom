# encoding: utf-8

require 'spec_helper'

describe Attribute, '#hash' do
  subject { object.hash }

  let(:described_class) { Class.new(Attribute)               }
  let(:name)            { :name                              }
  let(:required)        { true                               }
  let(:options)         { { required: required }             }
  let(:object)          { described_class.new(name, options) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ name.hash ^ required.hash }
end
