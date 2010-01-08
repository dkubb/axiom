require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#initialize' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { Relation::Body.new(@header, [ [ 1 ] ]) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@header) }

  it { should == [ [ 1 ] ] }
end
