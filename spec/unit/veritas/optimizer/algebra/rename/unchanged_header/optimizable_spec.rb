require 'spec_helper'

describe Optimizer::Algebra::Rename::UnchangedHeader, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.rename(new_aliases)                                      }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the header is not changed' do
    let(:new_aliases) { {} }

    it { should be(true) }
  end

  context 'when the header is changed' do
    let(:new_aliases) { { :id => :other_id } }

    it { should be(false) }
  end
end
