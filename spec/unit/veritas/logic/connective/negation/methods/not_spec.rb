require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe "Veritas::Logic::Connective::Negation::Methods##{method}" do
    subject { proposition.send(method, predicate) }

    let(:header)      { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate)   { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:proposition) { NegationMethodsSpecs::Object.new               }

    before do
      def proposition.eql?(other)
        equal?(other)
      end
    end

    it 'returns a conjunction of the proposition and a negated predicate' do
      should eql(Logic::Connective::Conjunction.new(proposition, Logic::Connective::Negation.new(predicate)))
    end
  end
end
