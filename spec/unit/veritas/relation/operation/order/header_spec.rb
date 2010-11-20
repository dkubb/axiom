require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#header' do
  subject { order.header }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Header) }

  it { should equal(relation.header) }
end
