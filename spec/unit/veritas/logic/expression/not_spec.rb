require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    before do
      @header    = Relation::Header.new([ [ :id, Integer ] ])
      @predicate = Logic::Predicate::Equality.new(@header[:id], 1)

      @expression = ExpressionSpecs::Object.new

      def @expression.eql?(other)
        equal?(other)
      end
    end

    subject { @expression.send(method, @predicate) }

    it { should be_kind_of(Logic::Connective::Conjunction) }

    it 'returns an expression ANDed with a negated predicate' do
      should eql(Logic::Connective::Conjunction.new(@expression, Logic::Connective::Negation.new(@predicate)))
    end
  end
end
