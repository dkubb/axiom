require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#header' do
  subject { object.header }

  let(:klass)    { Relation::Operation::Order                 }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:relation) { Relation.new(header, [ [ 1 ], [ 2 ] ])     }
  let(:object)   { klass.new(relation, header)                }

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
