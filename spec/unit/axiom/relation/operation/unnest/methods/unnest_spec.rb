# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Unnest::Methods, '#unnest' do
  subject { object.unnest(name) }

  let(:object)          { relation.nest(name => attributes) }
  let(:described_class) { Relation                          }
  let(:relation)        { described_class.new(header, body) }
  let(:header)          { [[:id, Integer], [:name, String]] }
  let(:body)            { [[1, 'John Doe']]                 }
  let(:name)            { :names                            }
  let(:attributes)      { [:name]                           }

  it { should be_instance_of(Relation::Operation::Unnest) }

  its(:header) { should == header }

  its(:to_a) { should eq([[1, 'John Doe']]) }
end
