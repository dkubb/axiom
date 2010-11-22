require 'spec_helper'

describe 'Veritas::Relation::Materialized#size' do
  subject { object.size }

  let(:klass)  { Relation::Materialized                     }
  let(:object) { klass.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it_should_behave_like 'an idempotent method'

  it { should == 1 }
end
