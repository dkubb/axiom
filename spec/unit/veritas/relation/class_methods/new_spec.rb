require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation.new' do
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  subject { Relation.new(header, tuples) }

  describe 'with an Enumerable responding to #size' do
    let(:tuples) { [ [ 1 ] ] }

    before do
      tuples.should respond_to(:size)
    end

    it { should be_instance_of(Relation::Materialized) }

    it { should == tuples }
  end

  describe 'with an Enumerable that does not respond to #size' do
    let(:range) { 1..5 }
    let(:tuples) do
      Enumerator.new do |yielder|
        range.each { |n| yielder.yield [ n ] }
      end
    end

    before do
      tuples.should_not respond_to(:size)
    end

    it { should be_instance_of(Relation) }

    it { should == range.map { |n| [ n ] } }
  end
end
