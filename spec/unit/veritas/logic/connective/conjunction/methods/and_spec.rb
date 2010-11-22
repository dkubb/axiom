require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :and, :& ].each do |method|
  describe "Veritas::Logic::Connective::Conjunction::Methods##{method}" do
    subject { object.send(method, predicate) }

    let(:klass)     { ConjunctionMethodsSpecs::Object            }
    let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
    let(:predicate) { header[:id].eq(1)                          }
    let(:object)    { klass.new                                  }

    it 'returns a conjunction of the proposition and predicate' do
      should eql(Logic::Connective::Conjunction.new(object, predicate))
    end
  end
end
