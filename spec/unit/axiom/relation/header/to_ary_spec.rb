# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#to_ary' do
  subject { object.to_ary }

  let(:attribute) { [:id, Integer]                      }
  let(:object)    { described_class.coerce([attribute]) }

  it { should be_instance_of(Array) }

  it { should == [attribute] }

  it { should be_frozen }
end
