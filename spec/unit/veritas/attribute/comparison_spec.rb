require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute' do
  subject { Attribute.new(:id, Integer) }

  it { should be_kind_of(Comparable) }

  it 'should case match Comparable' do
    (Comparable === subject).should be_true
  end
end

describe 'Veritas::Attribute#<=>' do
  before do
    @attribute = Attribute.new(:id, Integer)
  end

  subject { @attribute <=> @other }

  describe 'with an equivalent attribute' do
    before do
      @other = Attribute.new(:id, Integer)
    end

    it { should == 0 }
  end

  describe 'with a different attribute' do
    before do
      @other = Attribute.new(:name, String)
    end

    it { should_not == 0 }
  end

  describe 'with an equivalent object responding to #to_ary' do
    before do
      @other = [ :id, Integer ]
    end

    it { should == 0 }
  end

  describe 'with a different object responding to #to_ary' do
    before do
      @other = [ :name, String ]
    end

    it { should_not == 0 }
  end
end
