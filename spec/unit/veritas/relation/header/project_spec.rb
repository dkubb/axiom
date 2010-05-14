require 'spec_helper'

describe 'Veritas::Relation::Header#project' do
  subject { header.project([ :id ]) }

  let(:header) { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
