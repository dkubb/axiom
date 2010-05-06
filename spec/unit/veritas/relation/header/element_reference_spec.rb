require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#[]' do
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  subject { header[name] }

  describe 'with a known attribute name' do
    let(:name) { :id }

    it { should == [ :id, Integer ] }
  end

  describe 'with an unknown attribute name' do
    let(:name) { :name }

    it { should be_nil }
  end
end
