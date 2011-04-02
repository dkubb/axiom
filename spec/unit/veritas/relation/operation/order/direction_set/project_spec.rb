require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#project' do
  subject { object.project(attributes) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:attributes) { [ header[:id] ]                                               }
  let(:object)     { described_class.new(header)                                   }

  it { should_not equal(object) }

  it { should be_kind_of(described_class) }

  it { should == [ header[:id] ] }
end
