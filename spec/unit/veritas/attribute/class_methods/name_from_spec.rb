require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.name_from' do
  subject { Attribute.name_from(object) }

  context 'object is an Attribute' do
    let(:object) { Attribute::Integer.new(:id) }

    it { should == :id }
  end

  context 'object that responds to #to_ary' do
    let(:object) { [ :id, Integer ] }

    it { should == :id }
  end

  context 'object that responds to #to_sym' do
    let(:object) { 'id' }

    it { should == :id }
  end

  context 'object that is not an Attribute, does not respond to #to_ary or #to_sym' do
    let(:object) { Object.new }

    it { method(:subject).should raise_error(NoMethodError) }
  end
end
