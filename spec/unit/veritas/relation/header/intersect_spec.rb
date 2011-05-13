# encoding: utf-8

require 'spec_helper'

[ :intersect, :& ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:other)  { described_class.new([ [ :name, String  ] ]) }
    let(:object) { described_class.new([ [ :id,   Integer ] ]) }

    it { should be_kind_of(described_class) }

    it { should be_empty }
  end
end
