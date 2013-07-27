# encoding: utf-8

require 'spec_helper'

[:union, :|].each do |method|
  describe Relation::Keys, "##{method}" do
    subject { object.send(method, other) }

    let(:object) { described_class.coerce([header])       }
    let(:other)  { described_class.coerce([other_header]) }
    let(:header) { [[:id, Integer]]                       }

    context 'when the attributes overlap' do
      let(:other_header) { [[:id, Integer]] }

      it { should be(object) }
    end

    context 'when the attributes do not overlap' do
      let(:other_header) { [[:name, String]] }

      it { should be_instance_of(described_class) }

      it { should == [header, other_header] }
    end
  end
end
