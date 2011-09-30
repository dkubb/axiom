# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#hash' do
  subject { object.hash }

  let(:described_class) { Class.new(Aggregate)           }
  let(:object)          { described_class.new(attribute) }
  let(:attribute)       { Attribute::Integer.new(:id)    }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ attribute.hash }
end
