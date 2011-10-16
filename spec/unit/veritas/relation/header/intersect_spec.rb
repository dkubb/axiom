# encoding: utf-8

require 'spec_helper'

[ :intersect, :& ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:other)  { described_class.new(attributes)       }
    let(:object) { described_class.new(other_attributes) }

    context 'when the attributes overlap' do
      let(:attributes)       { [ [ :name, String ] ] }
      let(:other_attributes) { [ [ :name, String ] ] }

      it { should be_instance_of(described_class) }

      it { should == [ [ :name, String ] ] }
    end

    context 'when the attributes do not overlap' do
      let(:attributes)       { [ [ :name, String  ] ] }
      let(:other_attributes) { [ [ :id,   Integer ] ] }

      it { should be_instance_of(described_class) }

      it { should be_empty }
    end
  end
end
