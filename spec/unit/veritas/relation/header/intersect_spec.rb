require File.expand_path('../../../../../spec_helper', __FILE__)

[ :intersect, :& ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    let(:header) { Relation::Header.new([ [ :id,   Integer ] ]) }
    let(:other)  { Relation::Header.new([ [ :name, String  ] ]) }

    subject { header.send(method, other) }

    it { should be_kind_of(Relation::Header) }

    it { should be_empty }
  end
end
