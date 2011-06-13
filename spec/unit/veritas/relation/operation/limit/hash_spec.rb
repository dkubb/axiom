# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit, '#hash' do
  subject { object.hash }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:operand)  { relation.sort_by { |r| r[:id] }                             }
  let(:limit)    { 1                                                           }
  let(:object)   { described_class.new(operand, limit)                         }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ limit.hash }
end
