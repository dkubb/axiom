# encoding: utf-8

require 'spec_helper'

describe Relation, '#[]' do
  subject { object[name] }

  let(:name)      { :id                                                  }
  let(:attribute) { Attribute::Integer.new(name)                         }
  let(:object)    { described_class.new([attribute], LazyEnumerable.new) }

  before do
    object.should be_instance_of(described_class)
  end

  it { should be(attribute) }
end
