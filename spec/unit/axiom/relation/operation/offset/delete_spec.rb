# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Offset, '#delete' do
  subject { object.delete(other) }

  let(:object)  { described_class.new(operand, 1)                 }
  let(:other)   { stub('other')                                   }
  let(:operand) { Relation.new(header, [ [ 1 ] ]).sort_by(header) }
  let(:header)  { Relation::Header.coerce([ [ :id, Integer ] ])   }

  specify { expect { subject }.to raise_error(ImmutableRelationError, 'deleting from an offset is impossible') }
end
