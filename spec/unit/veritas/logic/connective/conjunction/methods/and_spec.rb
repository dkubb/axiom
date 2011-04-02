require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :and, :& ].each do |method|
  describe Logic::Connective::Conjunction::Methods, "##{method}" do
    subject { object.send(method, predicate) }

    let(:described_class) { ConjunctionMethodsSpecs::Object            }
    let(:header)          { Relation::Header.new([ [ :id, Integer ] ]) }
    let(:predicate)       { header[:id].eq(1)                          }
    let(:object)          { described_class.new.freeze                 }

    it 'returns a conjunction of the proposition and predicate' do
      should eql(Logic::Connective::Conjunction.new(object, predicate))
    end
  end
end
