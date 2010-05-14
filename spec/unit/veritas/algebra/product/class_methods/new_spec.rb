require 'spec_helper'

describe 'Veritas::Algebra::Product.new' do
  subject { Algebra::Product.new(left, right) }

  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }

  context 'with relations having headers with common attributes' do
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    specify { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be disjointed for Veritas::Algebra::Product.new') }
  end

  context 'with relations having equivalent headers' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }

    specify { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be disjointed for Veritas::Algebra::Product.new') }
  end

  context 'with relations having different headers' do
    let(:right) { Relation.new([ [ :number, Integer ] ], [ [ 2 ] ]) }

    specify { method(:subject).should_not raise_error }
  end
end
