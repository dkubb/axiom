# encoding: utf-8

require 'spec_helper'

describe Tuple, '#indices' do
  subject { object.indices }

  let(:id)     { Attribute::Integer.new(:id, :index => :item)         }
  let(:type)   { Attribute::String.new(:type, :index => :item)        }
  let(:name)   { Attribute::String.new(:name)                         }
  let(:header) { Relation::Header.new([ id, type, name ])             }
  let(:object) { described_class.new(header, [ 1, 'person', 'john' ]) }

  it { should be_instance_of(described_class) }

  it { should be_frozen }

  its(:to_ary) { should == [ 1, 'person' ] }
end
