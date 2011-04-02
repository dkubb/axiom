require 'spec_helper'

describe Optimizer::Algebra::Projection::UnchangedHeader, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.project(new_header)                                      }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  context 'when the header is not changed' do
    let(:new_header) { header }

    it { should be(true) }
  end

  context 'when the header is changed' do
    let(:new_header) { [ :id ] }

    it { should be(false) }
  end
end
