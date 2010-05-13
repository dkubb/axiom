require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order.new' do
  subject { Relation::Operation::Order.new(relation, directions) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  context 'with all attributes specified in the directions' do
    let(:directions) { [ relation[:id] ] }

    its(:relation) { should equal(relation) }

    its(:directions) { should == [ relation[:id].asc ] }
  end

  context 'without all attributes specified in the directions' do
    let(:directions) { [] }

    specify { method(:subject).should raise_error(ArgumentError, 'directions must include every attribute in the header') }
  end
end
