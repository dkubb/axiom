require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple.coerce' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { Tuple.coerce(@header, @object) }

  describe 'when the object is a Tuple' do
    before do
      @object = Tuple.new(@header, [ 1 ])
    end

    it { should equal(@object) }
  end

  describe 'when the object responds to #to_ary' do
    before do
      @object = [ 1 ]
    end

    it { should eql(Tuple.new(@header, [ 1 ])) }
  end
end
