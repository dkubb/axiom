require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.name_from' do
  subject { Attribute.name_from(@object) }

  describe 'object is an Attribute' do
    before do
      @object = Attribute.new(:id, Integer)
    end

    it { should == :id }
  end

  describe 'object that responds to #to_ary' do
    before do
      @object = [ :id, Integer ]
    end

    it { should == :id }
  end

  describe 'object that responds to #to_sym' do
    before do
      @object = 'id'
    end

    it { should == :id }
  end

  describe 'object that is not an Attribute, does not respond to #to_ary or #to_sym' do
    before do
      @object = Object.new
    end

    it { method(:subject).should raise_error(NoMethodError) }
  end
end
