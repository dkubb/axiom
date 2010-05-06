require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute' do
  subject { Attribute::Integer.new(:id) }

  it { should be_kind_of(Comparable) }

  it 'case matches Comparable' do
    (Comparable === subject).should be(true)
  end
end

describe 'Veritas::Attribute#<=>' do
  let(:attribute) { Attribute::Integer.new(:id) }

  subject { attribute <=> other }

  describe 'with an equivalent attribute' do
    let(:other) { Attribute::Integer.new(:id) }

    it { should == 0 }
  end

  describe 'with a different attribute' do
    let(:other) { Attribute::Time.new(:time) }

    it { should_not == 0 }
  end

  describe 'with an equivalent object responding to #to_ary' do
    let(:other) { [ :id, Integer ] }

    it { should == 0 }
  end

  describe 'with a different object responding to #to_ary' do
    let(:other) { [ :name, String ] }

    it { should_not == 0 }
  end
end
