require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit::Methods#first' do
  let(:klass)    { Relation                                                      }
  let(:relation) { klass.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ].each) }
  let(:object)   { relation.order                                                }

  context 'with no arguments' do
    subject { object.first }

    it { should be_kind_of(Relation::Operation::Limit) }

    its(:to_i) { should == 1 }

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

    it { should be_kind_of(Relation::Operation::Limit) }

    its(:to_i) { should == limit }

    it 'returns the expected tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end

    it 'behaves the same as Array#first' do
      should == object.to_a.first(limit)
    end
  end
end
