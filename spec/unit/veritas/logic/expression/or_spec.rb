require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

[ :or, :| ].each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    let(:header)     { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate)  { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:expression) { ExpressionSpecs::Object.new                    }

    subject { expression.send(method, predicate) }

    it { should be_kind_of(Logic::Connective::Disjunction) }
  end
end
