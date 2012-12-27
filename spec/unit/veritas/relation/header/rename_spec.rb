# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#rename' do
  subject { object.rename(aliases) }

  let(:object)  { described_class.coerce([ [ :id, Integer ], [ :name, String ] ], :keys => keys) }
  let(:aliases) { Algebra::Rename::Aliases.coerce(object, :id => :other_id)                      }
  let(:keys)    { Relation::Keys.new([ described_class.coerce([ [ :id, Integer ] ]) ])           }

  it { should be_instance_of(described_class) }

  it { should_not equal(object) }

  its(:to_ary) { should == [ [ :other_id, Integer ], [ :name, String ] ] }

  its(:keys) { should eql(Relation::Keys.new([ described_class.coerce([ [ :other_id, Integer ] ]) ])) }
end
