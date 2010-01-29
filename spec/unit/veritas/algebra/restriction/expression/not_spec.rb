require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Expression#not' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @expression = ExpressionSpecs::Object.new

    def @expression.eql?(other)
      equal?(other)
    end
  end

  subject { @expression.not(@predicate) }

  it { should be_kind_of(Algebra::Restriction::Conjunction) }

  it 'should return an expression ANDed with a negated predicate' do
    should eql(Algebra::Restriction::Conjunction.new(@expression, Algebra::Restriction::Negation.new(@predicate)))
  end
end

describe 'Veritas::Algebra::Restriction::Expression#-' do
  it 'is an alias to #not' do
    mod = Algebra::Restriction::Expression
    mod.instance_method(:-).should == mod.instance_method(:not)
  end
end
