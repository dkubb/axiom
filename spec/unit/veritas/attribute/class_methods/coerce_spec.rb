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
end
