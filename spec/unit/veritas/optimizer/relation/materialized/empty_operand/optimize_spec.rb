require 'spec_helper'

describe Optimizer::Relation::Materialized::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:relation) { Relation.new(header, [].each)              }
  let(:object)   { described_class.new(relation)              }

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }
end
