# encoding: utf-8

require 'spec_helper'

describe Attribute::String, '#hash' do
  subject { object.hash }

  let(:object)     { described_class.new(name, options) }
  let(:name)       { :name                              }
  let(:required)   { true                               }
  let(:min_length) { 0                                  }
  let(:max_length) { 50                                 }

  let(:options) do
    {
      required:   required,
      min_length: min_length,
      max_length: max_length,
    }
  end

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ name.hash ^ required.hash ^ min_length.hash ^ max_length.hash }
end
