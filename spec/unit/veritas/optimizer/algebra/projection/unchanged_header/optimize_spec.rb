require 'spec_helper'

describe Optimizer::Algebra::Projection::UnchangedHeader, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.project(header)                                          }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.should be_optimizable
  end

  it { should equal(base) }
end
