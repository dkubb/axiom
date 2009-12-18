require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#initialize' do
  before do
    @header = [ [ :id, Integer ] ]
    @body   = [ [ 1 ] ]
  end

  subject { Relation.new(@header, @body) }

  it { should be_kind_of(Relation) }

  it 'should set the header' do
    subject.header.should == @header
  end

  it 'should set the body' do
    subject.body.should == @body
  end
end
