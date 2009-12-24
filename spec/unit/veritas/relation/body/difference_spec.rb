require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#difference' do
  before do
    @header = mock('Header')

    @body  = Relation::Body.new(@header, [ [ 1 ] ])
    @other = Relation::Body.new(@header, [ [ 2 ] ])
  end

  subject { @body.difference(@other) }

  it { subject.header.should equal(@header) }

  it { subject.to_set.should == Set[ [ 1 ] ] }
end

describe 'Veritas::Relation::Body#-' do
  it 'is an alias to #difference' do
    Relation::Body.instance_method(:-).should == Relation::Body.instance_method(:difference)
  end
end
