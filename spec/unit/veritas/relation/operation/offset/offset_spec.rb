# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Offset, '#offset' do
  subject { object.offset }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.sort_by { |r| r[:id] }                             }
  let(:offset)   { 1                                                           }
  let(:object)   { described_class.new(order, offset)                          }

  it { should == offset }
end
