require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation.new' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { Relation.new(@header, @tuples) }

  describe 'with an Enumerable responding to #size' do
    before do
      @tuples = [ [ 1 ] ]

      @tuples.should respond_to(:size)
    end

    it { should be_instance_of(Relation::Materialized) }

    it { should == @tuples }
  end

  describe 'with an Enumerable that does not respond to #size' do
    before do
      @range  = 1..5
      @tuples = Enumerator.new do |yielder|
        @range.each { |n| yielder.yield [ n ] }
      end

      @tuples.should_not respond_to(:size)
    end

    it { should be_instance_of(Relation) }

    it { should == @range.map { |n| [ n ] } }
  end
end
