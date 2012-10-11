# encoding: utf-8

require 'spec_helper'

describe IndexSet, '#[]' do
  subject { object[name] }

  let(:name)   { :item }
  let(:id)     { Attribute::Integer.new(:id, :index => name)  }
  let(:type)   { Attribute::String.new(:type, :index => name) }
  let(:name)   { Attribute::String.new(:name)                 }
  let(:header) { Relation::Header.new([ id, type, name ])     }
  let(:tuple)  { Tuple.new(header, [ 1, 'person', 'john' ])   }
  let(:object) { described_class.new(tuple) }

  it { should be_instance_of(Tuple) }

  it { should == [ 1, 'person' ] }
end
