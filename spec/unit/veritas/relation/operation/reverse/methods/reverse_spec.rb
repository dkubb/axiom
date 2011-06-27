# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Reverse::Methods, '#reverse' do
  subject { object.reverse }

  let(:described_class) { Relation                                                         }
  let(:relation)        { described_class.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }
  let(:object)          { relation.sort_by { |r| r.id }                                    }

  it { should be_instance_of(Relation::Operation::Reverse) }

  it 'behaves the same as Array#reverse' do
    should == relation.to_a.reverse
  end
end
