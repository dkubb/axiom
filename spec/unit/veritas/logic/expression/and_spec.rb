require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

[ :and, :& ].each do |method|
  describe "Veritas::Logic::Expression##{method}" do
    subject { expression.send(method, predicate) }

    let(:header)     { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate)  { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:expression) { ExpressionSpecs::Object.new                    }

    it { should be_kind_of(Logic::Connective::Conjunction) }
  end
end
