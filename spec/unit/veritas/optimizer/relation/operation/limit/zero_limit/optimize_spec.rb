require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::ZeroLimit, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:order)    { Relation.new(header, [ [ 1 ] ].each).order }
  let(:relation) { order.take(0)                              }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }
end
