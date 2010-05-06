require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#hash' do
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  subject { tuple.hash }

  it { should be_kind_of(Integer) }

  it { should == header.hash ^ [ 1 ].hash }
end
