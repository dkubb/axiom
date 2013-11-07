# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#size' do
  subject { object.size }

  let(:object)     { described_class.new(attributes) }
  let(:attributes) { [Attribute::Integer.new(:id)]   }

  it_should_behave_like 'an idempotent method'

  it { should be(1) }
end
