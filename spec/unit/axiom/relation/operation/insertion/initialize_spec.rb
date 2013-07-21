# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Insertion, '#initialize' do
  subject { described_class.new(base, other) }

  let(:base)  { Relation.new([[:id, Integer]], [[1]]) }
  let(:other) { Relation.new([[:id, Integer]], [[2]]) }

  it { should be_instance_of(described_class) }

  its(:left) { should be(base) }

  its(:right) { should be(other) }
end
