require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe Logic::Connective::Negation::Methods, "##{method}" do
    subject { object.send(method, predicate) }

    let(:described_class) { NegationMethodsSpecs::Object                   }
    let(:header)          { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate)       { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:object)          { described_class.new                            }

    before do
      def object.eql?(other)
        equal?(other)
      end
      object.freeze
    end

    it 'returns a conjunction of the proposition and a inverted predicate' do
      should eql(Logic::Connective::Conjunction.new(object, Logic::Connective::Negation.new(predicate)))
    end
  end
end
