require 'spec_helper'

describe 'Veritas::Tuple#to_ary' do
  subject { object.to_ary }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  it { should be_kind_of(Array) }

  it { should == [ 1 ] }
end
