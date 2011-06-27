# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

[ :not, :- ].each do |method|
  describe Function::Connective::Negation::Methods, "##{method}" do
    let(:described_class) { NegationMethodsSpecs::Object               }
    let(:header)          { Relation::Header.new([ [ :id, Integer ] ]) }
    let(:object)          { described_class.new                        }

    before do
      def object.eql?(other)
        equal?(other)
      end
      object.freeze
    end

    context 'with no arguments' do
      subject { object.send(method) }

      it { should be_instance_of(Function::Connective::Negation) }

      its(:operand) { should equal(object) }
    end

    context 'when a function is provided' do
      subject { object.send(method, predicate) }

      let(:predicate) { Function::Predicate::Equality.new(header[:id], 1) }

      it { should be_instance_of(Function::Connective::Conjunction) }

      its(:left) { should equal(object) }

      its(:right) { should eql(Function::Connective::Negation.new(predicate)) }
    end
  end
end
