require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#each' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @left   = Relation.new(@header.project([ :id   ]), [ [ 1 ], [ 2 ] ])
    @right  = Relation.new(@header.project([ :name ]), [ [ 'Dan Kubb' ], [ 'Alex Kubb' ] ])

    @product = Algebra::Product.new(@left, @right)

    @yield = []
  end

  subject { @product.each { |tuple| @yield << tuple } }

  it { should equal(@product) }

  it 'should yield the product' do
    method(:subject).should change { @yield.dup }.
      from([]).
      to([ [ 1, 'Dan Kubb' ], [ 1, 'Alex Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ])
  end
end
