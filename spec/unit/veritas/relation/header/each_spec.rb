require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header' do
  subject { Relation::Header.new }

  it { should be_kind_of(Enumerable) }

  it 'should case match Enumerable' do
    (Enumerable === subject).should be_true
  end
end

describe 'Veritas::Relation::Header#each' do
  before do
    @attribute = Attribute.new(:id, Integer)

    @tuples = []
    @header = Relation::Header.new([ @attribute ])
  end

  subject { @header.each { |tuple| @tuples << tuple } }

  it { should equal(@header) }

  it 'should yield each tuple in the body' do
    method(:subject).should change { @tuples.dup }.from([]).to([ @attribute ])
  end
end
