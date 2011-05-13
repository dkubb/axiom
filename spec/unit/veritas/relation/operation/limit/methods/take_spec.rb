# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#take' do
  subject { object.take(limit) }

  let(:described_class) { Relation                                                         }
  let(:limit)           { 1                                                                }
  let(:relation)        { described_class.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }
  let(:object)          { relation.order                                                   }

  it { should be_kind_of(Relation::Operation::Limit) }

  its(:limit) { should == limit }

  it 'behaves the same as Array#take' do
    should == object.to_a.take(limit)
  end
end
