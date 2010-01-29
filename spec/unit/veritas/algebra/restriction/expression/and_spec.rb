require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Expression#and' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @expression = ExpressionSpecs::Object.new
  end

  subject { @expression.and(@predicate) }

  it { should be_kind_of(Algebra::Restriction::Conjunction) }
end

describe 'Veritas::Algebra::Restriction::Expression#&' do
  it 'is an alias to #and' do
    mod = Algebra::Restriction::Expression
    mod.instance_method(:&).should == mod.instance_method(:and)
  end
end
