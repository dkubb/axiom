# encoding: utf-8

require 'spec_helper'

describe Attribute::String, '#hash' do
  subject { object.hash }

  let(:object)         { described_class.new(name, options) }
  let(:name)           { :name                              }
  let(:required)       { true                               }
  let(:minimum_length) { 0                                  }
  let(:maximum_length) { 50                                 }

  let(:options) do
    {
      required:       required,
      minimum_length: minimum_length,
      maximum_length: maximum_length,
    }
  end

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ name.hash ^ object.type.hash ^ required.hash }
end
