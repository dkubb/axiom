require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

[ :or, :| ].each do |method|
  describe "Veritas::Logic::Connective::Methods##{method}" do
    subject { proposition.send(method, predicate) }

    let(:header)      { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate)   { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:proposition) { ConnectiveMethodsSpecs::Object.new            }

    it 'returns a disjunction of the proposition and predicate' do
      should eql(Logic::Connective::Disjunction.new(proposition, predicate))
    end
  end
end
