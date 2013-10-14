# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted::Direction, '#hash' do
  subject { object.hash }

  let(:described_class) { Class.new(Relation::Operation::Sorted::Direction) }
  let(:attribute)       { Attribute::Integer.new(:id)                       }
  let(:object)          { described_class.new(attribute)                    }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ attribute.hash }
end
