# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#project' do
  subject { object.project(attributes) }

  let(:header)     { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:attributes) { [header[:id]]                                              }
  let(:object)     { described_class.coerce(header)                             }

  it { should_not equal(object) }

  it { should be_instance_of(described_class) }

  it { should == [header[:id]] }
end
