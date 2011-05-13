# encoding: utf-8

require 'spec_helper'

describe Attribute, '#name' do
  subject { object.name }

  let(:described_class) { Attribute::Integer        }
  let(:name)            { :id                       }
  let(:object)          { described_class.new(name) }

  it { should == name }
end
