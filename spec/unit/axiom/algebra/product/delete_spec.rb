# encoding: utf-8

require 'spec_helper'

describe Algebra::Product, '#delete' do
  subject { object.delete(other) }

  let(:object) { described_class.new(left, right)                        }
  let(:other)  { double('other')                                         }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])           }
  let(:right)  { Relation.new([ [ :name, String ] ], [ [ 'John Doe' ] ]) }

  specify { expect { subject }.to raise_error(ImmutableRelationError, 'deleting from a product is impossible') }
end
