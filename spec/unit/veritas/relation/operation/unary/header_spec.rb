require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#header' do
  subject { unary_operation.header }

  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  it { should be_kind_of(Relation::Header) }

  it { should equal(relation.header) }
end
