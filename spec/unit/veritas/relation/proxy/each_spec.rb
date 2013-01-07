# encoding: utf-8

require 'spec_helper'

describe Relation::Proxy, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)          { described_class.new(relation)            }
  let(:described_class) { Class.new(Relation)                      }
  let(:relation)        { Relation.new([ [ :id, Integer ] ], body) }
  let(:body)            { [ [ 1 ], [ 2 ] ]                         }
  let(:yields)          { []                                       }

  before do
    described_class.class_eval do
      include Veritas::Relation::Proxy

      def initialize(relation)
        @relation = relation
      end
    end
  end

  it_should_behave_like 'an #each method'

  it 'yields only tuples' do
    subject
    yields.each { |tuple| tuple.should be_instance_of(Tuple) }
  end

  it 'yields only tuples with the expected header' do
    subject
    yields.each { |tuple| tuple.header.should be(object.header) }
  end

  it 'yields only tuples with the expected data' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to(body)
  end
end
