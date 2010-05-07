require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#hash' do
  subject { header.hash }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  it { should be_kind_of(Integer) }

  it { should == header.to_ary.hash }
end
