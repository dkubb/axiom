require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#rename' do
  subject { object.rename(aliases) }

  let(:klass)     { Relation::Operation::Order::DirectionSet                  }
  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }
  let(:object)    { klass.new([ attribute ])                                  }

  it { should_not equal(object) }

  it { should be_kind_of(klass) }

  it { should == [ Attribute::Integer.new(:other_id) ] }
end
