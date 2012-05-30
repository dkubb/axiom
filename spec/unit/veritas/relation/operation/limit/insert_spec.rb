# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit, '#insert' do
  subject { object.insert(other) }

  let(:object)  { described_class.new(operand, 1)                 }
  let(:other)   { stub('other')                                   }
  let(:operand) { Relation.new(header, [ [ 1 ] ]).sort_by(header) }
  let(:header)  { Relation::Header.new([ [ :id, Integer ] ])      }

  specify { expect { subject }.to raise_error(ImmutableRelationError, 'inserting into a limit is impossible') }
end
