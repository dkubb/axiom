require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    let(:header)     { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate)  { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:expression) { ExpressionSpecs::Object.new                    }

    subject { expression.send(method, predicate) }

    before do
      def expression.eql?(other)
        equal?(other)
      end
    end

    it { should be_kind_of(Logic::Connective::Conjunction) }

    it 'returns an expression ANDed with a negated predicate' do
      should eql(Logic::Connective::Conjunction.new(expression, Logic::Connective::Negation.new(predicate)))
    end
  end
end
