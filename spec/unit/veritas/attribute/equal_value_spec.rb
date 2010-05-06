require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#==' do
  let(:name)      { :id                          }
  let(:attribute) { Attribute::Integer.new(name) }

  subject { attribute == other }

  describe 'with the same attribute' do
    let(:other) { attribute }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == attribute)
    end
  end

  describe 'with an equivalent attribute' do
    let(:other) { attribute.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == attribute)
    end
  end

  describe 'with a different attribute' do
    let(:other) { Attribute::String.new(:name) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == attribute)
    end
  end

  describe 'with an equivalent attribute of a different class' do
    let(:other) { Class.new(Attribute::Integer).new(name) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == attribute)
    end
  end
end
