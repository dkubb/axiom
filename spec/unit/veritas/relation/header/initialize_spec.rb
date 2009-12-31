require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#initialize' do
  describe 'with attributes' do
    before do
      @attribute = mock('Attribute')
    end

    subject { Relation::Header.new([ @attribute ]) }

    it { should be_kind_of(Relation::Header) }

    it { subject.to_ary.should == [ @attribute ] }
  end

  describe 'without attributes' do
    subject { Relation::Header.new }

    it { should be_kind_of(Relation::Header) }

    it { subject.to_ary.should be_empty }
  end
end
