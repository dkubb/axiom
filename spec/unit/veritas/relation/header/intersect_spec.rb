require 'spec_helper'

[ :intersect, :& ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    subject { header.send(method, other) }

    let(:header) { Relation::Header.new([ [ :id,   Integer ] ]) }
    let(:other)  { Relation::Header.new([ [ :name, String  ] ]) }

    it { should be_kind_of(Relation::Header) }

    it { should be_empty }
  end
end
