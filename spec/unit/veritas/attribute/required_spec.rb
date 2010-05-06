require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#required?' do
  subject { attribute.required? }

  describe 'without :required option passed to constructor' do
    let(:attribute) { Attribute::Integer.new(:id) }

    it { should be(true) }
  end

  describe 'with :required => true option passed to constructor' do
    let(:attribute) { Attribute::Integer.new(:id, :required => true) }

    it { should be(true) }
  end

  describe 'with :required => false option passed to constructor' do
    let(:attribute) { Attribute::Integer.new(:id, :required => false) }

    it { should be(false) }
  end
end
