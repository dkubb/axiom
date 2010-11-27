require 'spec_helper'

describe 'Veritas::Relation::Operation::Reverse.new' do
  subject { object.new(relation) }

  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:object)            { Relation::Operation::Reverse                         }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }

    it { should be_kind_of(object) }

    it 'reverses the directions' do
      subject.directions.should == relation.directions.reverse
    end
  end

  context 'with an ordered relation having an empty header' do
    let(:relation) { original_relation.order { |r| r[:id] }.project([]) }

    it { should be_kind_of(object) }

    it 'reverses the directions' do
      subject.directions.should == relation.directions.reverse
    end
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }

    specify { expect { subject }.to raise_error(OrderedRelationRequiredError, 'can only reverse an ordered operand') }
  end
end
