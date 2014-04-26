# encoding: utf-8

require 'spec_helper'

describe Tuple, '#extend' do
  subject { object.extend(new_header, extensions) }

  let(:header)     { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:new_header) { header | [[:test, Integer]]                                }
  let(:object)     { described_class.new(header, [1, 'Dan Kubb'])               }

  context 'when the extension is a Proc' do
    let(:extensions) { [->(tuple) { 1 }] }

    it { should be_instance_of(described_class) }

    its(:header) { should be(new_header) }

    its(:to_ary) { should == [1, 'Dan Kubb', 1] }
  end

  context 'when the extension is a Function' do
    let(:extensions) { [header[:id].abs] }

    it { should be_instance_of(described_class) }

    its(:header) { should be(new_header) }

    its(:to_ary) { should == [1, 'Dan Kubb', 1] }
  end

  context 'when the extension is a value' do
    let(:extensions) { [1] }

    it { should be_instance_of(described_class) }

    its(:header) { should be(new_header) }

    its(:to_ary) { should == [1, 'Dan Kubb', 1] }
  end
end
