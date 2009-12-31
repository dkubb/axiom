require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#intersect' do
  before do
    @body  = Relation::Header.new([ mock('Attribute 1') ])
    @other = Relation::Header.new([ mock('Attribute 2') ])
  end

  subject { @body.intersect(@other) }

  it { should be_kind_of(Relation::Header) }

  it { subject.should be_empty }
end

describe 'Veritas::Relation::Header#&' do
  it 'is an alias to #intersect' do
    Relation::Header.instance_method(:&).should == Relation::Header.instance_method(:intersect)
  end
end
