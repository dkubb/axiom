# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension, '#insert' do
  subject { object.insert(other) }

  let(:object)         { described_class.new(operand, extensions)            }
  let(:operand)        { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:extensions)     { { extension_attr => 1 }                             }
  let(:extension_attr) { Attribute::Integer.new(:test)                       }
  let(:header)         { [ [ :id, Integer ] ]                                }

  context 'when other relation has matching extensions' do
    let(:other) do
      Relation.new(header, LazyEnumerable.new([ [ 2 ] ])).extend do |context|
        context.add(:test, 1)
      end
    end

    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == [ [ :id, Integer ], [ :test, Integer ] ] }

    it 'inserts the tuples' do
      should == [ [ 1, 1 ], [ 2, 1 ] ]
    end
  end

  context 'when other relation does not have the same extensions' do
     let(:other) do
      Relation.new(header, LazyEnumerable.new([ [ 2 ] ])).extend do |context|
        context.add(:test, 2)
      end
    end

    specify { expect { subject }.to raise_error(ExtensionMismatchError, 'other relation must have matching extensions to be inserted') }
  end

  context 'when other relation is not an extension' do
    let(:other) { Relation.new(header, LazyEnumerable.new([ [ 2 ] ])) }

    specify { expect { subject }.to raise_error(ExtensionMismatchError, 'other relation must have matching extensions to be inserted') }
  end
end
