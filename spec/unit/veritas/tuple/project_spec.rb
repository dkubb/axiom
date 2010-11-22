require 'spec_helper'

describe 'Veritas::Tuple#project' do
  subject { object.project(reversed_header) }

  let(:klass)           { Tuple                                                         }
  let(:header)          { Relation::Header.new([ [ :name, String ], [ :id, Integer ] ]) }
  let(:reversed_header) { Relation::Header.new(header.to_a.reverse)                     }
  let(:object)          { klass.new(header, [ 'Dan Kubb', 1 ])                          }

  it { should be_kind_of(klass) }

  its(:header) { should equal(reversed_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb' ] }
end
