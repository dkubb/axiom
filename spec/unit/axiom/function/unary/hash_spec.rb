# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Unary, '#hash' do
  subject { object.hash }

  let(:described_class) { UnarySpecs::Object                   }
  let(:attribute)       { Attribute::Integer.new(:id)          }
  let(:header)          { Relation::Header.coerce([attribute]) }
  let(:operand)         { attribute.eq(1)                      }
  let(:object)          { described_class.new(operand)         }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash }
end
