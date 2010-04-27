require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe "Veritas::Algebra::Restriction::Expression##{method}" do
    before do
      @header    = Relation::Header.new([ [ :id, Integer ] ])
      @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

      @expression = ExpressionSpecs::Object.new

      def @expression.eql?(other)
        equal?(other)
      end
    end

    subject { @expression.send(method, @predicate) }

    it { should be_kind_of(Algebra::Restriction::Conjunction) }

    it 'returns an expression ANDed with a negated predicate' do
      should eql(Algebra::Restriction::Conjunction.new(@expression, Algebra::Restriction::Negation.new(@predicate)))
    end
  end
end
