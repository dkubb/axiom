require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#to_ary' do
  let(:attribute) { [ :id, Integer ]                    }
  let(:header)    { Relation::Header.new([ attribute ]) }

  subject { header.to_ary }

  it { should be_instance_of(Array) }

  it { should == [ attribute ] }
end
