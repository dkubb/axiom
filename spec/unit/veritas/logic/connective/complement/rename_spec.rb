require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#rename' do
  subject { complement.rename(aliases) }

  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:other)     { attribute.rename(:other_id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }

  context 'operand is renamed' do
    let(:operand)    { attribute.eq(1)                            }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should eql(Logic::Connective::Complement.new(other.eq(1))) }
  end

  context 'operand is not renamed' do
    let(:operand)    { other.eq(1)                                }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should equal(complement) }
  end
end
