require 'spec_helper'

describe 'Veritas::Relation::Header#[]' do
  subject { object[name] }

  let(:klass)  { Relation::Header                }
  let(:object) { klass.new([ [ :id, Integer ] ]) }

  context 'with a known attribute name' do
    let(:name) { :id }

    it { should == [ :id, Integer ] }
  end

  context 'with an unknown attribute name' do
    let(:name) { :name }

    it { should be_nil }
  end
end
