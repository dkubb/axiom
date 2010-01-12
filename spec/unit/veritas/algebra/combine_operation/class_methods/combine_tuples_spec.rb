require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::CombineOperation.combine_tuples' do
  before do
    @yield = []
  end

  subject { Algebra::CombineOperation.combine_tuples([ [ 1 ] ], [ 2 ]) { |tuple| @yield << tuple } }

  it 'should yield each combined tuple' do
    method(:subject).should change { @yield.dup }.from([]).to([ [ 1, 2 ] ])
  end
end
