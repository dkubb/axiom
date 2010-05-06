require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Materialized#size' do
  let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  subject { relation.size }

  it { should == 1 }
end
