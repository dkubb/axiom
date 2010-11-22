require 'spec_helper'

describe 'Veritas::Relation::Operation::Order.new' do
  subject { object.new(relation, directions) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:object)   { Relation::Operation::Order                           }

  context 'with all attributes specified in the directions' do
    let(:directions) { [ relation[:id] ] }

    it { should be_kind_of(object) }

    its(:operand) { should equal(relation) }

    its(:directions) { should == [ relation[:id].asc ] }
  end

  context 'without all attributes specified in the directions' do
    let(:directions) { [] }

    specify { expect { subject }.to raise_error(InvalidDirectionsError, 'directions must include every attribute in the header') }
  end
end
