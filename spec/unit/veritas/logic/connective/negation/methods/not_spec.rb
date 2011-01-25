require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe "Veritas::Logic::Connective::Negation::Methods##{method}" do
    subject { object.send(method, predicate) }

    let(:klass)     { NegationMethodsSpecs::Object                   }
    let(:header)    { Relation::Header.new([ [ :id, Integer ] ])     }
    let(:predicate) { Logic::Predicate::Equality.new(header[:id], 1) }
    let(:object)    { klass.new                                      }

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
