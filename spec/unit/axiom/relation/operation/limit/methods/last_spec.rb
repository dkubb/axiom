# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#last' do
  let(:described_class) { Relation                                                                               }
  let(:relation)        { described_class.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ], [ 2 ], [ 3 ] ])) }
  let(:object)          { relation.sort_by { |r| r.id }                                                          }

  context 'with no arguments' do
    subject { object.last }

    it { should be_instance_of(Relation::Operation::Reverse) }

    it 'returns the expected tuples' do
      should == [ [ 3 ] ]
    end

    it 'behaves similar to Array#last' do
      should == [ object.to_a.last ]
    end
  end

  context 'with a limit' do
    subject { object.last(limit) }

    let(:limit) { 2 }

    it { should be_instance_of(Relation::Operation::Reverse) }

    it 'returns the expected tuples' do
      should == [ [ 2 ], [ 3 ] ]
    end

    it 'behaves the same as Array#last' do
      should == object.to_a.last(limit)
    end
  end
end
