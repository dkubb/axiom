require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Set#header' do
  subject { object.header }

  let(:klass)  { SetOperationSpecs::Object                     }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:right)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object) { klass.new(left, right)                        }

  it { should equal(left.header) }

  it_should_behave_like 'an idempotent method'
end
