# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Unary, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { UnarySpecs::Object                                     }
  let(:attribute)       { Attribute::Integer.new(:id)                            }
  let(:other)           { attribute.rename(:other_id)                            }
  let(:header)          { Relation::Header.new([attribute])                      }
  let(:aliases)         { Algebra::Rename::Aliases.coerce(header, id: :other_id) }
  let(:object)          { described_class.new(operand)                           }

  context 'operand is renamed' do
    let(:operand) { attribute.eq(1) }

    it { should be_instance_of(described_class) }

    its(:operand) { should eql(other.eq(1)) }
  end

  context 'operand is not renamed' do
    let(:operand) { other.eq(1) }

    it { should be(object) }
  end
end
