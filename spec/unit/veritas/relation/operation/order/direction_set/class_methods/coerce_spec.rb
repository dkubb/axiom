require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet.coerce' do
  subject { Relation::Operation::Order::DirectionSet.coerce(object) }

  let(:directions)    { [ :id ]                                                  }
  let(:direction_set) { Relation::Operation::Order::DirectionSet.new(directions) }

  context 'when the object is a DirectionSet' do
    let(:object) { direction_set }

    it { should equal(object) }
  end

  context 'when the object responds to #to_ary' do
    let(:object) { directions }

    it { should eql(direction_set) }
  end

  context 'when the object is not a DirectionSet and does not respond to #to_ary' do
    let(:object) { { :id => Integer } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
