require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#project' do
  subject { tuple.project(reversed_header) }

  let(:header)          { Relation::Header.new([ [ :name, String ], [ :id, Integer ] ]) }
  let(:reversed_header) { Relation::Header.new(header.to_a.reverse)                     }
  let(:tuple)           { Tuple.new(header, [ 'Dan Kubb', 1 ])                          }

  it { should be_kind_of(Tuple) }

  its(:header) { should equal(reversed_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb' ] }
end
