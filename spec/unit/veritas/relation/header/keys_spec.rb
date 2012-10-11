# encoding: utf-8

require 'spec_helper'

describe Relation::Header, "#keys" do
  subject { object.keys }

  let(:id)     { Attribute::Integer.new(:id, :key => true) }
  let(:name)   { Attribute::String.new(:name)              }
  let(:object) { described_class.new([ id, name ])         }

  it { should be_instance_of(described_class) }

  it { should == [ id ] }
end
