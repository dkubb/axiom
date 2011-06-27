# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Relation::Operation::Binary, '#header' do
  subject { object.header }

  let(:described_class) { BinaryRelationOperationSpecs::Object                     }
  let(:left)            { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
  let(:right)           { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:object)          { described_class.new(left, right)                         }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it { should == [ [ :id, Integer ], [ :name, String ] ] }
end
