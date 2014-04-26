# encoding: utf-8

require 'spec_helper'

[:fetch, :[]].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, name) }

    let(:object)    { described_class.coerce([attribute]) }
    let(:attribute) { Attribute::Integer.new(:id)         }

    context 'with a known attribute' do
      let(:name) { attribute }

      it { should == [:id, Integer] }
    end

    context 'with a known attribute name' do
      let(:name) { :id }

      it { should == [:id, Integer] }
    end

    context 'with an unknown attribute' do
      let(:name) { Attribute::String.new(:name) }

      specify { expect { subject }.to raise_error(UnknownAttributeError, 'the attribute name is unknown') }
    end

    context 'with an unknown attribute name' do
      let(:name) { :name }

      specify { expect { subject }.to raise_error(UnknownAttributeError, 'the attribute name is unknown') }
    end
  end
end
