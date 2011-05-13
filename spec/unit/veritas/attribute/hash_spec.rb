# encoding: utf-8

require 'spec_helper'

describe Attribute, '#hash' do
  subject { object.hash }

  let(:described_class) { Attribute::Integer                 }
  let(:name)            { :id                                }
  let(:options)         { { :size => 1..10 }                 }
  let(:object)          { described_class.new(name, options) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ name.hash ^ options.hash }
end
