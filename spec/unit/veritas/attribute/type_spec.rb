# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Attribute)       }
  let(:object)          { described_class.new(:name) }

  it { should equal(described_class) }
end
