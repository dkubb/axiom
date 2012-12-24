# encoding: utf-8

require 'spec_helper'

[ :union, :| ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:object) { described_class.coerce([ [ :id, Integer ] ], :keys => keys) }
    let(:other)  { described_class.coerce(other_attributes,     :keys => keys) }
    let(:keys)   { Relation::Keys.new([ described_class.new ])                 }

    context 'when the attributes overlap' do
      let(:other_attributes) { [ [ :id, Integer ] ] }

      it { pending { should equal(object) } }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should == other_attributes }

      its(:keys) { should eql(keys) }
    end

    context 'when the attributes do not overlap' do
      let(:other_attributes) { [ [ :name, String ] ] }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should == [ [ :id, Integer ], [ :name, String ] ] }

      its(:keys) { should eql(keys) }
    end
  end
end
