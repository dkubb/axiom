require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join.new' do
  let(:header) { [ [ :id, Integer ] ]                   }
  let(:left)   { Relation.new(header, [ [ 1 ], [ 2 ] ]) }

  subject { Algebra::Join.new(left, right) }

  describe 'with relations having headers with common attributes' do
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    it { method(:subject).should_not raise_error }
  end

  describe 'with relations having equivalent headers' do
    let(:right) { left.dup }

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers are identical, use intersection instead') }
  end

  describe 'with relations having different headers' do
    let(:right) { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]) }

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers must have common attributes for Veritas::Algebra::Join.new') }
  end
end
