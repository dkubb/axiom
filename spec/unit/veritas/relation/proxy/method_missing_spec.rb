# encoding: utf-8

require 'spec_helper'

describe Relation::Proxy, '#method_missing' do
  subject { object.unknown }

  let(:object)          { described_class.new(relation)            }
  let(:described_class) { Class.new(Relation)                      }
  let(:relation)        { Relation.new([ [ :id, Integer ] ], body) }
  let(:body)            { [ [ 1 ], [ 2 ] ]                         }

  before do
    described_class.class_eval do
      include Veritas::Relation::Proxy

      def initialize(relation)
        @relation = relation
      end
    end
  end

  specify { expect { subject }.to raise_error(NoMethodError) }
end
