# encoding: utf-8

require 'spec_helper'

describe Algebra::Product, '#insert' do
  subject { object.insert(other) }

  let(:object) { described_class.new(left, right)                        }
  let(:other)  { stub('other')                                           }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])           }
  let(:right)  { Relation.new([ [ :name, String ] ], [ [ 'John Doe' ] ]) }

  specify { expect { subject }.to raise_error(ImmutableRelationError, 'inserting into a product is impossible') }
end
