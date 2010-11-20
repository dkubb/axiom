require 'spec_helper'

describe 'Veritas::Algebra::Restriction#predicate' do
  subject { object.predicate }

  let(:klass)     { Algebra::Restriction                          }
  let(:relation)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:predicate) { relation[:id].ne(0)                           }
  let(:object)    { klass.new(relation, predicate)                }

  it_should_behave_like 'an idempotent method'

  it { should equal(predicate) }
end
