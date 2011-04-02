require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#last' do
  let(:klass)    { Relation                                                      }
  let(:relation) { klass.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ].each) }
  let(:object)   { relation.order                                                }

  context 'with no arguments' do
    subject { object.last }

    it { should be_kind_of(Relation::Operation::Reverse) }

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

    it { should be_kind_of(Relation::Operation::Reverse) }

    it 'returns the expected tuples' do
      should == [ [ 2 ], [ 3 ] ]
    end

    it 'behaves the same as Array#last' do
      should == object.to_a.last(limit)
    end
  end
end
