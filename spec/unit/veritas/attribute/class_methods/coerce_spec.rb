require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.coerce' do
  subject { Attribute.coerce(@object) }

  describe 'when the object is an Attribute' do
    before do
      @object = Attribute.new(:id, Integer)
    end

    it { should equal(@object) }
  end

  describe 'when the object responds to #to_ary' do
    before do
      @object = [ :id, Integer ]
    end

    it { should eql(Attribute.new(:id, Integer)) }
  end

  describe 'when the object is not an Attribute and does not respond to #to_ary' do
    before do
      @object = { :id => Integer }
    end

    it { method(:subject).should raise_error(ArgumentError, 'object must be either Veritas::Attribute or respond to #to_ary, but was Hash') }
  end
end
