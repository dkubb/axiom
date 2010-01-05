require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#initialize' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  describe 'with a header' do
    subject { Relation::Body.new(@header) }

    it { should be_kind_of(Relation::Body) }

    it { subject.header.should equal(@header) }

    it { subject.to_set.should be_empty }
  end

  describe 'with a header and tuples' do
    subject { Relation::Body.new(@header, [ [ 1 ] ]) }

    it { should be_kind_of(Relation::Body) }

    it { subject.header.should equal(@header) }

    it { should == [ [ 1 ] ] }
  end
end
