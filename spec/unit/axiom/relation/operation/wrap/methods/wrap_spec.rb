# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Wrap::Methods, '#wrap' do
  subject { object.wrap(name => attributes) }

  let(:object)          { described_class.new(header, body) }
  let(:described_class) { Relation                          }
  let(:header)          { [[:id, Integer], [:name, String]] }
  let(:body)            { [[1, 'John Doe']]                 }
  let(:name)            { :names                            }
  let(:attributes)      { [:name]                           }

  it { should be_instance_of(Relation::Operation::Wrap) }

  its(:header) do
    should == [
      Attribute::Integer.new(:id),
      Attribute::Tuple.new(:names, header: [[:name, String]]),
    ]
  end

  its(:to_a) { should eq([[1, ['John Doe']]]) }
end
