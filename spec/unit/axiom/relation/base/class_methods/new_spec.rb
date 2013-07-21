# encoding: utf-8

require 'spec_helper'

describe Relation::Base, '.new' do
  let(:name)   { 'users'.freeze                            }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:object) { described_class                           }

  context 'when no tuples are provided' do
    subject { object.new(name, header) }

    it { should be_instance_of(described_class) }

    its(:name) { should equal(name) }

    its(:header) { should equal(header) }

    it { should be_empty }
  end

  context 'when tuples are provided' do
    subject { object.new(name, header, tuples) }

    let(:tuples) { LazyEnumerable.new([[1]]) }

    it { should be_instance_of(described_class) }

    its(:name) { should equal(name) }

    its(:header) { should equal(header) }

    it { should == tuples }
  end
end
