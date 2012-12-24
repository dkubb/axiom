# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#rename' do
  subject { object.rename(aliases) }

  let(:object)  { described_class.new([ header1, header2 ])                  }
  let(:header1) { Relation::Header.coerce([ [ :id, Integer ] ])              }
  let(:header2) { Relation::Header.coerce([ [ :name, String ] ])             }
  let(:aliases) { Algebra::Rename::Aliases.coerce(header1, :id => :other_id) }

  it { should be_instance_of(described_class) }

  it { should == described_class.new([ Relation::Header.coerce([ [ :other_id, Integer ] ]), header2 ]) }
end
