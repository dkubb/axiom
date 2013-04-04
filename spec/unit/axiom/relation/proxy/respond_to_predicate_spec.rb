# encoding: utf-8

require 'spec_helper'

describe Relation::Proxy, '#respond_to?' do
  subject { object.respond_to?(method) }

  let(:object)          { described_class.new(relation)            }
  let(:described_class) { Class.new(Relation)                      }
  let(:relation)        { Relation.new([ [ :id, Integer ] ], body) }
  let(:body)            { [ [ 1 ], [ 2 ] ]                         }

  before do
    described_class.class_eval do
      include Relation::Proxy

      def initialize(relation)
        @relation = relation
      end
    end
  end

  context 'with a known method in the proxy' do
    let(:method) { :header }

    it { should be(true) }
  end

  context 'with a known method in the relation' do
    let(:method) { :each }

    it { should be(true) }
  end

  context 'with an unknown method' do
    let(:method) { :unknown }

    it { should be(false) }
  end
end
