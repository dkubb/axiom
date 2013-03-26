# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Direction, '#name' do
  subject { object.name }

  let(:described_class) { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute)       { Attribute::Integer.new(:id)                      }
  let(:object)          { described_class.new(attribute)                   }

  it { should equal(:id) }
end
