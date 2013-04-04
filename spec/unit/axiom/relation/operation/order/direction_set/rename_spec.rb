# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#rename' do
  subject { object.rename(aliases) }

  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }
  let(:object)    { described_class.coerce([ attribute ])                     }

  it { should_not equal(object) }

  it { should be_instance_of(described_class) }

  it { should == [ Attribute::Integer.new(:other_id) ] }
end
