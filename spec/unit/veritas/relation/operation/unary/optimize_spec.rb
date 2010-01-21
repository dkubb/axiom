require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#optimize' do
  subject { @unary_operation.optimize }

  describe 'with an empty relation' do
    before do
      @empty = Relation::Empty.new([ [ :id, Integer ] ])

      @unary_operation = UnaryOperationSpecs::Object.new(@empty)
    end

    it { should equal(@empty) }
  end

  describe 'with an non-empty relation' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

      @unary_operation = UnaryOperationSpecs::Object.new(@relation)
    end

    it 'should attempt to delegate to the superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end
end
