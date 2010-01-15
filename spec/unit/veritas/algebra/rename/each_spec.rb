require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#each' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @rename = Algebra::Rename.new(@relation, :id => :other_id)

    @yield = []
  end

  subject { @rename.each { |tuple| @yield << tuple } }

  it { should equal(@rename) }

  it 'should yield each tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
  end

  it 'should change the header for each tuple' do
    subject
    @yield.first.header.should equal(@rename.header)
  end
end
