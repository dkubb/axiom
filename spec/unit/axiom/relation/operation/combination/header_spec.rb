# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Relation::Operation::Combination, '#header' do
  subject { object.header }

  let(:described_class) { CombinationOperationSpecs::Object                        }
  let(:left)            { Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])   }
  let(:right)           { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:object)          { described_class.new(left, right)                         }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it 'unions the headers' do
    should == [ [ :id, Integer ], [ :name, String ] ]
  end
end
