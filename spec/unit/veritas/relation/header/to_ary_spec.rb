require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#to_ary' do
  subject { header.to_ary }

  let(:attribute) { [ :id, Integer ]                    }
  let(:header)    { Relation::Header.new([ attribute ]) }

  it { should be_instance_of(Array) }

  it { should == [ attribute ] }
end
