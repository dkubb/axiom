# encoding: utf-8

require 'spec_helper'

[:intersect, :&].each do |method|
  describe Relation::Keys, "##{method}" do
    subject { object.send(method, other) }

    let(:object) { described_class.coerce([header])       }
    let(:other)  { described_class.coerce([other_header]) }
    let(:header) { [[:id]]                                }

    context 'when the attributes overlap' do
      let(:other_header) { header.dup }

      it { should be(object) }
    end

    context 'when the attributes do not overlap' do
      let(:other_header) { [[:name]] }

      it { should be_instance_of(described_class) }

      it { should be_empty }
    end
  end
end
