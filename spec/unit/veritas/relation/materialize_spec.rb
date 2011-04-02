require 'spec_helper'

describe Relation, '#materialize' do
  subject { object.materialize }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:object) { described_class.new(header, [ [ 1 ] ].each).order }

  before do
    object.should be_kind_of(described_class)
  end

  it { should be_kind_of(Relation::Materialized) }

  its(:header) { should equal(header) }

  its(:directions) { should == header }

  it 'returns an equivalent relation to the unmaterialized operation' do
    should == object
  end
end
