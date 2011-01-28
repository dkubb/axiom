require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::UnchangedHeader#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::UnchangedHeader                   }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.rename({})                                               }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  it { should equal(base) }
end
