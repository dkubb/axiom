# encoding: utf-8

require 'spec_helper'

describe Tuple, '#keys' do
  subject { object.keys }

  let(:id)     { Attribute::Integer.new(:id, :key => true)  }
  let(:name)   { Attribute::String.new(:name)               }
  let(:header) { Relation::Header.new([ id, name ])         }
  let(:object) { described_class.new(header, [ 1, 'John' ]) }

  it { should be_instance_of(described_class) }

  it { should be_frozen }

  its(:to_ary) { should == [ 1 ] }
end
