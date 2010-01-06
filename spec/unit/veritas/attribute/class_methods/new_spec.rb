require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.new' do
  describe 'when called on the Attribute class' do
    subject { Attribute.new(:id) }

    it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Attribute.new is an abstract method') }
  end

  describe 'when called on an Attribute subclass' do
    subject { Attribute::Integer.new(:id) }

    it { should eql(Attribute::Integer.new(:id)) }
  end
end
