require 'spec_helper'

describe 'Veritas::Attribute.coerce' do
  subject { Attribute.coerce(object) }

  context 'when the object is an Attribute' do
    let(:object) { Attribute::Integer.new(:id) }

    it { should equal(object) }
  end

  context 'when the object responds to #to_ary' do
    let(:object) { [ :id, Integer ] }

    it { should eql(Attribute::Integer.new(:id)) }
  end

  context 'when the object does not respond to #to_ary, but does respond to #to_sym' do
    let(:object) { :id }

    it { should eql(Attribute::Object.new(:id)) }
  end

  context 'when the object does not respond to #to_ary or #to_sym' do
    let(:object) { Integer }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
