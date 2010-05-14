require 'spec_helper'

describe 'Veritas::Algebra::Projection#header' do
  subject { projection.header }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:projection) { Algebra::Projection.new(relation, [ :id ])    }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
