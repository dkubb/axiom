require 'spec_helper'

describe 'Veritas::Algebra::Join.new' do
  subject { Algebra::Join.new(left, right) }

  let(:header) { [ [ :id, Integer ] ]                   }
  let(:left)   { Relation.new(header, [ [ 1 ], [ 2 ] ]) }

  context 'with relations having headers with common attributes' do
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    specify { expect { subject }.to_not raise_error }
  end

  context 'with relations having equivalent headers' do
    let(:right) { left.dup }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers are identical, use intersection instead') }
  end

  context 'with relations having different headers' do
    let(:right) { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]) }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must have common attributes for Veritas::Algebra::Join.new') }
  end
end
