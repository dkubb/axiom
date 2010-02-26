require File.expand_path('../../../../../spec_helper', __FILE__)

[ :intersect, :& ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    before do
      @header = Relation::Header.new([ [ :id,   Integer ] ])
      @other  = Relation::Header.new([ [ :name, String  ] ])
    end

    subject { @header.send(method, @other) }

    it { should be_kind_of(Relation::Header) }

    it { should be_empty }
  end
end
