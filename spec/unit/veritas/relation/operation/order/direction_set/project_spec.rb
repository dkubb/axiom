require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#project' do
  subject { object.project(attributes) }

  let(:klass)      { Relation::Operation::Order::DirectionSet                      }
  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:attributes) { [ header[:id] ]                                               }
  let(:object)     { klass.new(header)                                             }

  it { should_not equal(object) }

  it { should be_kind_of(klass) }

  it { should == [ header[:id] ] }
end
