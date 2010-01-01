require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#==' do
  before do
    @attribute = Attribute.new(:id, Integer)
  end

  subject { @attribute == @other }

  describe 'with an equivalent relation' do
    before do
      @other = @attribute.dup
    end

    it { should be_true }
  end

  describe 'with a different relation' do
    before do
      @other = Attribute.new(:name, String)
    end

    it { should be_false }
  end
end
