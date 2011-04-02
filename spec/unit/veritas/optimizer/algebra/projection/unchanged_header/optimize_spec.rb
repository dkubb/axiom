require 'spec_helper'

describe Optimizer::Algebra::Projection::UnchangedHeader, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Projection::UnchangedHeader               }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.project(header)                                          }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  it { should equal(base) }
end
