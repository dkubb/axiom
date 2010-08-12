require 'spec_helper'

describe 'Veritas::Algebra::Restriction#predicate' do
  subject { restriction.predicate }

  let(:relation)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:predicate)   { relation[:id].ne(0)                           }
  let(:restriction) { Algebra::Restriction.new(relation, predicate) }

  it { should equal(predicate) }

  it_should_behave_like 'an idempotent method'
end
