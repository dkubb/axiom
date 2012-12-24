# encoding: utf-8

require 'spec_helper'

[ :union, :| ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:object) { described_class.coerce([ [ :id, Integer ] ]) }

    context 'when the attributes overlap' do
      let(:other) { [ [ :id, Integer ] ] }

      it { pending { should equal(object) } }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should == other }
    end

    context 'when the attributes do not overlap' do
      let(:other) { [ [ :name, String ] ] }

      it { should be_instance_of(described_class) }

      its(:to_ary) { should == [ [ :id, Integer ], [ :name, String ] ] }
    end
  end
end
