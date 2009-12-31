require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#intersect' do
  before do
    @header = mock('Header')

    @body  = Relation::Body.new(@header, [ mock('Tuple 1') ])
    @other = Relation::Body.new(@header, [ mock('Tuple 2') ])
  end

  subject { @body.intersect(@other) }

  it { subject.header.should equal(@header) }

  it { subject.to_set.should == Set[] }
end

describe 'Veritas::Relation::Body#&' do
  it 'is an alias to #intersect' do
    Relation::Body.instance_method(:&).should == Relation::Body.instance_method(:intersect)
  end
end
