# encoding: utf-8

require 'spec_helper'

describe Relation::Header, "#indices" do
  subject { object.indices }

  let(:id)     { Attribute::Integer.new(:id, :index => :item)  }
  let(:type)   { Attribute::String.new(:type, :index => :item) }
  let(:name)   { Attribute::String.new(:name)                  }
  let(:object) { described_class.new([ id, type, name ])       }

  it { should be_instance_of(described_class) }

  it { should == [ id, type ] }
end
