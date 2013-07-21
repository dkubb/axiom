# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#reverse' do
  subject { object.reverse }

  let(:attribute1) { Attribute::Integer.new(:id)                      }
  let(:attribute2) { Attribute::String.new(:name)                     }
  let(:object)     { described_class.coerce([attribute1, attribute2]) }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(described_class) }

  it 'reverses each direction' do
    should == [attribute1.desc, attribute2.desc]
  end

  it 'does not reverse the attribute order' do
    subject.attributes.should eql([attribute1, attribute2])
  end
end
