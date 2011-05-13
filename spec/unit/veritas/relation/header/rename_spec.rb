# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#rename' do
  subject { object.rename(aliases) }

  let(:aliases) { Algebra::Rename::Aliases.coerce(object, :id => :other_id)    }
  let(:object)  { described_class.new([ [ :id, Integer ], [ :name, String ] ]) }

  it { should be_kind_of(described_class) }

  it { should_not equal(object) }

  it { should == [ [ :other_id, Integer ], [ :name, String ] ] }
end
