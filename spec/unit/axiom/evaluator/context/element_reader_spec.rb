# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#[]' do
  subject { object[name] }

  let(:name)      { :id                                      }
  let(:attribute) { Attribute::Integer.new(name)             }
  let(:header)    { Relation::Header.new([attribute])        }
  let(:object)    { described_class.new(header, &EMPTY_PROC) }

  it { should be(attribute) }
end
