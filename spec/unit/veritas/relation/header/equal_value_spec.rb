require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#==' do
  before do
    @attribute = mock('Attribute')

    @header = Relation::Header.new([ @attribute ])
  end

  subject { @header == @other }

  describe 'with equivalent attributes' do
    before do
      @other = Relation::Header.new([ @attribute ])
    end

    it { should be_true }
  end

  describe 'with different attributes' do
    before do
      @other = Relation::Header.new([ mock('Different Attribute') ])
    end

    it { should be_false }
  end

  describe 'with an equivalent object responding to #to_ary' do
    before do
      @other = [ @attribute ]
    end

    it { should be_true }
  end

  describe 'with a different object responding to #to_ary' do
    before do
      @other = [ mock('Different Attribute') ]
    end

    it { should be_false }
  end
end
