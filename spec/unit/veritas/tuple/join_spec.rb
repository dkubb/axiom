require 'spec_helper'

describe 'Veritas::Tuple#join' do
  subject { object.join(new_header, values) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:new_header) { header | [ [ :name, String ] ]             }
  let(:values)     { [ 'Dan Kubb' ]                             }
  let(:object)     { Tuple.new(header, [ 1 ])                   }

  it { should be_kind_of(Tuple) }

  its(:header) { should equal(new_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb' ] }
end
