require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#union' do
  before do
    @header = mock('Header')

    @body  = Relation::Body.new(@header, [ [ 1 ] ])
    @other = Relation::Body.new(@header, [ [ 2 ] ])
  end

  subject { @body.union(@other) }

  it { subject.header.should equal(@header) }

  it { subject.to_set.should == Set[ [ 1 ], [ 2 ] ] }
end

describe 'Veritas::Relation::Body#|' do
  it 'is an alias to #union' do
    Relation::Body.instance_method(:|).should == Relation::Body.instance_method(:union)
  end
end
