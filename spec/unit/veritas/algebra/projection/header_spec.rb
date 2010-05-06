require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#header' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:projection) { Algebra::Projection.new(relation, [ :id ])    }

  subject { projection.header }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
