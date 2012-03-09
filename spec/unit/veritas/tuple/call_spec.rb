# encoding: utf-8

require 'spec_helper'


[ :call, :[] ].each do |method|
  describe Tuple, "##{method}" do
    subject { object.send(method, attribute) }

    let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
    let(:object) { described_class.new(header, [ 1 ])         }

    context 'with a known attribute' do
      let(:attribute) { header[:id] }

      it { should == 1 }
    end

    context 'with an unknown attribute' do
      let(:attribute) { Attribute::Integer.new(:other_id) }

      specify { expect { subject }.to raise_error(UnknownAttributeError, 'the attribute other_id is unknown') }
    end
  end
end
