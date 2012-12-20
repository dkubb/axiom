# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#take' do
  subject { object.take(limit) }

  let(:described_class) { Relation                                                                        }
  let(:limit)           { 1                                                                               }
  let(:relation)        { described_class.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ], [ 2 ] ])) }
  let(:object)          { relation.sort_by { |r| r.id }                                                   }

  it { should be_instance_of(Relation::Operation::Limit) }

  its(:limit) { should == limit }

  it 'behaves the same as Array#take' do
    should == object.to_a.take(limit)
  end
end
