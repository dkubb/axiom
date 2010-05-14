require 'spec_helper'

describe 'Veritas::Tuple#inspect' do
  subject { tuple.inspect }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  it { should be_kind_of(String) }

  it { should == '[1]' }
end
