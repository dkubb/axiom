# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Nest::Methods, '#nest' do
  subject { object.nest(name => attributes) }

  let(:object)          { described_class.new(header, body) }
  let(:described_class) { Relation                          }
  let(:header)          { [[:id, Integer], [:name, String]] }
  let(:body)            { [[1, 'John Doe']]                 }
  let(:name)            { :names                            }
  let(:attributes)      { [:name]                           }

  it { should be_instance_of(Relation::Operation::Nest) }

  its(:header) do
    should == [
      Attribute::Integer.new(:id),
      Attribute::Relation.new(:names, header: [[:name, String]]),
    ]
  end

  its(:to_a) { should eq([[1, [['John Doe']]]]) }
end
