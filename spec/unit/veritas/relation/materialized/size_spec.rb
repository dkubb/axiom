require 'spec_helper'

describe 'Veritas::Relation::Materialized#size' do
  subject { relation.size }

  let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should == 1 }
end
