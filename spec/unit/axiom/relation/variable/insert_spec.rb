# encoding: utf-8

require 'spec_helper'

describe Relation::Variable, '#insert' do
  subject { object.insert(other) }

  let(:object)   { described_class.new(relation)              }
  let(:relation) { Relation::Base.new('users', header, [[1]]) }
  let(:other)    { [[2]]                                      }
  let(:header)   { [[:id, Integer]]                           }

  it { should be_instance_of(described_class) }

  it { should_not be_materialized }

  it { should == [[1], [2]] }
end
