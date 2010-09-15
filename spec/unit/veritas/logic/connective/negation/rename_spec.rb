require 'spec_helper'

describe 'Veritas::Logic::Connective::Negation#rename' do
  subject { negation.rename(aliases) }

  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:other)     { attribute.rename(:other_id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }

  context 'operand is renamed' do
    let(:operand)  { attribute.eq(1)                          }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should eql(Logic::Connective::Negation.new(other.eq(1))) }
  end

  context 'operand is not renamed' do
    let(:operand)  { other.eq(1)                              }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should equal(negation) }
  end
end
