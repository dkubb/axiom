require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Materialized::EmptyOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Materialized::EmptyOperand }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])      }
  let(:relation) { Relation.new(header, [].each)                   }
  let(:object)   { klass.new(relation)                             }

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }
end
