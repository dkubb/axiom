# encoding: utf-8

require 'spec_helper'

[ :union, :| ].each do |method|
  describe Relation::Keys, "##{method}" do
    subject { object.send(method, other) }

    let(:object) { described_class.new([ header       ])        }
    let(:other)  { described_class.new([ other_header ])        }
    let(:header) { Relation::Header.coerce([ [ :id, Integer] ]) }

    context 'when the attributes overlap' do
      let(:other_header) { Relation::Header.coerce([ [ :id, Integer ] ]) }

      it { should equal(object) }
    end

    context 'when the attributes do not overlap' do
      let(:other_header) { Relation::Header.coerce([ [ :name, String ] ]) }

      it { should be_instance_of(described_class) }

      it { should == described_class.new([ header, other_header ]) }
    end
  end
end
