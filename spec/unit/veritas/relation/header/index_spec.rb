require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#index' do
  subject { header.index(object) }

  let(:attribute) { [ :id, Integer ]                    }
  let(:header)    { Relation::Header.new([ attribute ]) }

  context 'with a known attribute' do
    let(:object) { attribute }

    it { should == 0 }
  end

  context 'with an unknown attribute' do
    let(:object) { [ :name, String ] }

    it { should be_nil }
  end
end
