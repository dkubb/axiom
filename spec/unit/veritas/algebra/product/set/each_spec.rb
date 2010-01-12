require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product::Set#each' do
  before do
    @left   = Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])
    @right  = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ], [ 'Alex Kubb' ] ])

    @set = Algebra::Product::Set.new(@left, @right)

    @yield = []
  end

  subject { @set.each { |tuple| @yield << tuple } }

  it { should equal(@set) }

  it 'should yield the product' do
    method(:subject).should change { @yield.dup }.
      from([]).
      to([ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 1, 'Alex Kubb' ], [ 2, 'Alex Kubb' ] ])
  end
end
