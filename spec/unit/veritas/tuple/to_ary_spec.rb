require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#to_ary' do
  subject { tuple.to_ary }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  it { should be_instance_of(Array) }

  it { should == [ 1 ] }
end
