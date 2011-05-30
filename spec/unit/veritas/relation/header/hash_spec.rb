# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#hash' do
  subject { object.hash }

  let(:attribute) { Attribute::Integer.new(:id)        }
  let(:object)    { described_class.new([ attribute ]) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ { :id => attribute }.hash }
end
