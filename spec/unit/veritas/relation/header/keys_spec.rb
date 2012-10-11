# encoding: utf-8

require 'spec_helper'

describe Relation::Header, "#keys" do
  subject { object.keys }

  let(:attribute1) { Attribute::Integer.new(:id, :key => true) }
  let(:attribute2) { Attribute::String.new(:name)              }
  let(:object)     { described_class.new([ attribute1 ])       }
  let(:other)      { described_class.new([ attribute2 ])       }

  it { should be_instance_of(described_class) }

  it { should == [ attribute1 ] }
end
