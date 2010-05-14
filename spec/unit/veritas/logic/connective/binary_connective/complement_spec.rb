require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#complement' do
  subject { connective.complement }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:left)       { Logic::Predicate::Equality.new(header[:id], 1)                }
  let(:right)      { Logic::Predicate::Equality.new(header[:id], 2)                }
  let(:connective) { BinaryConnectiveSpecs::Object.new(left, right)                }

  before do
    def connective.eql?(other)
      equal?(other)
    end
  end

  it 'negates the connective' do
    should eql(Logic::Connective::Negation.new(connective))
  end

  it 'is reversible' do
    subject.complement.should eql(connective)
  end
end
