# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Relation::Operation::Unary, '#header' do
  subject { object.header }

  let(:described_class) { UnaryOperationSpecs::Object                }
  let(:header)          { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:relation)        { Relation.new(header, [ [ 1 ] ])            }
  let(:object)          { described_class.new(relation)              }

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
