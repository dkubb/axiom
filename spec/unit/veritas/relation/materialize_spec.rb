require 'spec_helper'

describe Relation, '#materialize' do
  subject { object.materialize }

  let(:klass)  { Relation                                   }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ [ 1 ] ].each).order    }

  before do
    object.should be_kind_of(klass)
  end

  it { should be_kind_of(Relation::Materialized) }

  its(:header) { should equal(header) }

  its(:directions) { should == header }

  it 'returns an equivalent relation to the unmaterialized operation' do
    should == object
  end
end
