require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#[]' do
  subject { relation[:id] }

  let(:header)   { [ [ :id, Integer ] ]     }
  let(:relation) { Relation.new(header, []) }

  it { should be_kind_of(Attribute::Integer) }

  it { should == [ :id, Integer ] }
end
