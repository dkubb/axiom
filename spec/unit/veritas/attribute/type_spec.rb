# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#type' do
  subject { object.type }

  let(:described_class) { Attribute::Integer       }
  let(:object)          { described_class.new(:id) }

  it { should equal(described_class) }
end
