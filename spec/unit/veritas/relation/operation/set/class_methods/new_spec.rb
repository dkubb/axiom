require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Set::ClassMethods#new' do
  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }

  subject { SetOperationSpecs::Object.new(left, right) }

  context 'with relations having headers with common attributes' do
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    specify { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be equivalent for SetOperationSpecs::Object.new') }
  end

  context 'with relations having equivalent headers' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }

    specify { method(:subject).should_not raise_error }
  end

  context 'with relations having different headers' do
    let(:right) { Relation.new([ [ :number, Integer ] ], [ [ 2 ] ]) }

    specify { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be equivalent for SetOperationSpecs::Object.new') }
  end
end
