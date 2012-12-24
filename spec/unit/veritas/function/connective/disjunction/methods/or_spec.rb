# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :or, :| ].each do |method|
  describe Function::Connective::Disjunction::Methods, "##{method}" do
    subject { object.send(method, predicate) }

    let(:described_class) { DisjunctionMethodsSpecs::Object               }
    let(:header)          { Relation::Header.coerce([ [ :id, Integer ] ]) }
    let(:predicate)       { header[:id].eq(1)                             }
    let(:object)          { described_class.new.freeze                    }

    it 'returns a disjunction of the proposition and predicate' do
      should eql(Function::Connective::Disjunction.new(object, predicate))
    end
  end
end
