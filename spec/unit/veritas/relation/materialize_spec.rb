require 'spec_helper'

describe 'Veritas::Relation#materialize' do
  subject { object.materialize }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { Relation.new(header, [ [ 1 ] ].each).order }

  it { should be_kind_of(Relation::Materialized) }

  its(:header) { should equal(header) }

  it 'returns an equivalent relation to the unmaterialized operation' do
    should == object
  end
end
