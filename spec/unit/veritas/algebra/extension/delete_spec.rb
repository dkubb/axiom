# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension, '#delete' do
  subject { object.delete(other) }

  let(:object)         { described_class.new(operand, extensions)    }
  let(:operand)        { Relation.new(header, [ [ 1 ], [ 2 ] ].each) }
  let(:extensions)     { { extension_attr => 1 }                     }
  let(:extension_attr) { Attribute::Integer.new(:test)               }
  let(:header)         { [ [ :id, Integer ] ]                        }

  context 'when other relation has matching extensions' do
    let(:other) do
      Relation.new(header, [ [ 2 ] ].each).extend do |context|
        context.add(:test, 1)
      end
    end

    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == [ [ :id, Integer ], [ :test, Integer ] ] }

    it 'deletes the tuples' do
      should == [ [ 1, 1 ] ]
    end
  end

  context 'when other relation does not have the same extensions' do
     let(:other) do
      Relation.new(header, [ [ 2 ] ].each).extend do |context|
        context.add(:test, 2)
      end
    end

    specify { expect { subject }.to raise_error(ExtensionMismatchError, 'other relation must have matching extensions to be deleted') }
  end

  context 'when other relation is not an extension' do
    let(:other) { Relation.new(header, [ [ 2 ] ].each) }

    specify { expect { subject }.to raise_error(ExtensionMismatchError, 'other relation must have matching extensions to be deleted') }
  end
end
