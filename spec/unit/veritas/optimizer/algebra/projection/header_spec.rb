require 'spec_helper'

describe Optimizer::Algebra::Projection, '#header' do
  subject { object.header }

  let(:klass)    { Optimizer::Algebra::Projection                                }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:operand)  { Relation.new(header, [ [ 1, 'Dan Kubb' ] ])                   }
  let(:relation) { operand.project([ :id ])                                      }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  it { should equal(relation.header) }
end
