require 'spec_helper'

describe Relation::Header, '#rename' do
  subject { object.rename(aliases) }

  let(:klass)   { Relation::Header                                          }
  let(:aliases) { Algebra::Rename::Aliases.coerce(object, :id => :other_id) }
  let(:object)  { klass.new([ [ :id, Integer ], [ :name, String ] ])        }

  it { should be_kind_of(klass) }

  it { should_not equal(object) }

  it { should == [ [ :other_id, Integer ], [ :name, String ] ] }
end
