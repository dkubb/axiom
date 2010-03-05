require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Materialized#size' do
  before do
    @relation = Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.size }

  it { should == 1 }
end
