require File.expand_path('../../../spec_helper', __FILE__)

include Veritas

describe Relation do
  before do
    @header = [ [ :id, Integer ] ]
    @body   = [ [ 1 ] ]
  end

  describe '.new' do
    subject { Relation.new(@header, @body) }

    it { should be_kind_of(Relation) }
  end

  describe '#|' do
    it 'is an alias to #union' do
      Relation.instance_method(:|).should == Relation.instance_method(:union)
    end
  end

  describe '#union' do
    before do
      @relation = Relation.new(@header, @body)
      @other    = Relation.new(@header, [ [ 2 ] ])
    end

    subject { @relation.union(@other) }

    it { should be_kind_of(Algebra::Union) }
  end
end
