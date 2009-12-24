require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#initialize' do
  before do
    @header = mock('Header')
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

    it { subject.to_set.should == Set[ [ 1 ] ] }
  end
end
