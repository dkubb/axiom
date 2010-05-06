require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#inspect' do
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  subject { tuple.inspect }

  it { should be_kind_of(String) }

  it { should == '[1]' }
end
