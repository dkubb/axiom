require 'spec_helper'

describe Relation::Materialized, '#materialize' do
  subject { object.materialize }

  let(:klass)  { Relation::Materialized                     }
  let(:object) { klass.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should equal(object) }
end
