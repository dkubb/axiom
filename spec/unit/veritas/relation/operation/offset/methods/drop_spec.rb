# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Offset::Methods, '#drop' do
  subject { object.drop(offset) }

  let(:described_class) { Relation                                                                        }
  let(:offset)          { 1                                                                               }
  let(:relation)        { described_class.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ], [ 2 ] ])) }
  let(:object)          { relation.sort_by { |r| r.id }                                                   }

  it { should be_instance_of(Relation::Operation::Offset) }

  its(:offset) { should == offset }

  it 'behaves the same as Array#drop' do
    should == object.to_a.drop(1)
  end
end
