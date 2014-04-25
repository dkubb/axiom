# encoding: utf-8

require 'spec_helper'

describe Relation::Base, '.new' do
  let(:name)   { :users                                    }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:object) { described_class                           }

  context 'when a Sting is provided for the name' do
    subject { object.new(name.to_s, header) }

    it { should be_instance_of(described_class) }

    its(:name) { should be(name) }

    its(:header) { should be(header) }

    it { should be_empty }
  end

  context 'when no tuples are provided' do
    subject { object.new(name, header) }

    it { should be_instance_of(described_class) }

    its(:name) { should be(name) }

    its(:header) { should be(header) }

    it { should be_empty }
  end

  context 'when tuples are provided' do
    subject { object.new(name, header, tuples) }

    let(:tuples) { LazyEnumerable.new([[1]]) }

    it { should be_instance_of(described_class) }

    its(:name) { should be(name) }

    its(:header) { should be(header) }

    it { should == tuples }
  end
end
