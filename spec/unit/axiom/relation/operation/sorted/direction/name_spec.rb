# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted::Direction, '#name' do
  subject { object.name }

  let(:described_class) { Class.new(Relation::Operation::Sorted::Direction) }
  let(:attribute)       { Attribute::Integer.new(:id)                       }
  let(:object)          { described_class.new(attribute)                    }

  it { should be(:id) }
end
