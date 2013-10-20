# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Group, '#header' do
  subject { object.header }

  let(:object)   { described_class.new(relation, :names, [:name]) }
  let(:relation) { Relation.new(header, [])                       }
  let(:header)   { [[:id, Integer], [:name, String]]              }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it 'returns the expected attributes' do
    should == [
      Attribute::Integer.new(:id),
      Attribute::Relation.new(:names, header: [[:name, String]]),
    ]
  end
end
