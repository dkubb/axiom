# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#first' do
  let(:described_class) { Relation                                                                               }
  let(:relation)        { described_class.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ], [ 2 ], [ 3 ] ])) }
  let(:object)          { relation.sort_by { |r| r.id }                                                          }

  context 'with no arguments' do
    subject { object.first }

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:limit) { should == 1 }

    it 'returns the expected tuples' do
      should == [ [ 1 ] ]
    end

    it 'behaves similar to Array#first' do
      should == [ object.to_a.first ]
    end
  end

  context 'with a limit' do
    subject { object.first(limit) }

    let(:limit) { 2 }

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:limit) { should == limit }

    it 'returns the expected tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end

    it 'behaves the same as Array#first' do
      should == object.to_a.first(limit)
    end
  end
end
