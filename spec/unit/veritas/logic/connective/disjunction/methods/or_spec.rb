require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :or, :| ].each do |method|
  describe "Veritas::Logic::Connective::Disjunction::Methods##{method}" do
    subject { object.send(method, predicate) }

    let(:klass)     { DisjunctionMethodsSpecs::Object            }
    let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
    let(:predicate) { header[:id].eq(1)                          }
    let(:object)    { klass.new                                  }

    it 'returns a disjunction of the proposition and predicate' do
      should eql(Logic::Connective::Disjunction.new(object, predicate))
    end
  end
end
