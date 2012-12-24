# encoding: utf-8

require 'spec_helper'

[ :call, :[] ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, name) }

    let(:object) { described_class.coerce([ [ :id, Integer ] ]) }

    context 'with a known attribute name' do
      let(:name) { :id }

      it { should == [ :id, Integer ] }
    end

    context 'with an unknown attribute name' do
      let(:name) { :name }

      specify { expect { subject }.to raise_error(UnknownAttributeError, 'the attribute name is unknown') }
    end
  end
end
