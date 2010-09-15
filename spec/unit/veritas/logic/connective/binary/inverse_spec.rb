require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::Binary#inverse' do
  subject { connective.inverse }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:left)       { Logic::Predicate::Equality.new(header[:id], 1)                }
  let(:right)      { Logic::Predicate::Equality.new(header[:id], 2)                }
  let(:connective) { BinarySpecs::Complement.new(left, right)                      }

  it 'inverts the connective' do
    should eql(Logic::Connective::Complement.new(connective))
  end

  it 'is invertible' do
    subject.inverse.should equal(connective)
  end

  it_should_behave_like 'an idempotent method'
end
