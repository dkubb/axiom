require 'spec_helper'

describe 'Veritas::Relation::Materialized#materialize' do
  subject { object.materialize }

  let(:object) { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should equal(object) }
end
