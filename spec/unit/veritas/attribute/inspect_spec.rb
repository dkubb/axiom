# encoding: utf-8

require 'spec_helper'

describe Attribute, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Attribute::Integer       }
  let(:object)          { described_class.new(:id) }

  it { should be_instance_of(String) }

  it { should == '<Attribute::Integer name: id>' }
end
