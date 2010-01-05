require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#initialize' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { Tuple.new(@header, [ 1 ]) }

  it { should be_kind_of(Tuple) }

  it 'should set the header' do
    subject.header.should equal(@header)
  end

  it 'should set the internal state' do
    subject.to_ary.should == [ 1 ]
  end
end
