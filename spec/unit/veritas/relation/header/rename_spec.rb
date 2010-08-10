require 'spec_helper'

describe 'Veritas::Relation::Header#rename' do
  subject { header.rename(aliases) }

  let(:header)  { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:aliases) { Algebra::Rename::Aliases.coerce(header, :id => :other_id)     }

  it { should be_kind_of(Relation::Header) }

  it { should_not equal(header) }

  its(:to_ary) { should == [ [ :other_id, Integer ], [ :name, String ] ] }
end
