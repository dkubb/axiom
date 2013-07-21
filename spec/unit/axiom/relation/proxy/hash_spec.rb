# encoding: utf-8

require 'spec_helper'

describe Relation::Proxy, '#hash' do
  subject { object.hash }

  let(:object)          { described_class.new(relation)        }
  let(:described_class) { Class.new(Relation)                  }
  let(:relation)        { Relation.new([[:id, Integer]], body) }
  let(:body)            { [[1], [2]]                           }

  before do
    described_class.class_eval do
      include Relation::Proxy

      def initialize(relation)
        @relation = relation
      end
    end
  end

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ relation.hash }
end
