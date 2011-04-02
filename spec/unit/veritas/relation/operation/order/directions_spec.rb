require 'spec_helper'

describe Relation::Operation::Order, '#directions' do
  subject { object.directions }

  let(:klass)      { Relation::Operation::Order                           }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { klass::DirectionSet.new(relation.header)             }
  let(:object)     { klass.new(relation, directions)                      }

  it_should_behave_like 'an idempotent method'

  it { should equal(directions) }
end
