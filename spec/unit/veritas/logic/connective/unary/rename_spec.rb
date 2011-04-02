require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Connective::Unary, '#rename' do
  subject { object.rename(aliases) }

  let(:klass)     { UnarySpecs::Object                                        }
  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:other)     { attribute.rename(:other_id)                               }
  let(:header)    { Relation::Header.new([ attribute ])                       }
  let(:aliases)   { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }
  let(:object)    { klass.new(operand)                                        }

  context 'operand is renamed' do
    let(:operand) { attribute.eq(1) }

    it { should be_kind_of(klass) }

    its(:operand) { should == other.eq(1) }
  end

  context 'operand is not renamed' do
    let(:operand) { other.eq(1) }

    it { should equal(object) }
  end
end
