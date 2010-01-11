require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#restrict' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = proc { true }

    @body = Relation::Body.new(@header, [ [ 1 ] ])
  end

  subject { @body.restrict(@predicate) }

  it { should be_kind_of(Relation::Body) }

  it { subject.header.should equal(@header) }

  it { should == [ [ 1 ] ] }
end
