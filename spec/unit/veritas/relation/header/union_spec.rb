require File.expand_path('../../../../../spec_helper', __FILE__)

[ :union, :| ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    before do
      @attribute1 = [ :id,   Integer ]
      @attribute2 = [ :name, String  ]

      @header = Relation::Header.new([ @attribute1 ])
      @other  = Relation::Header.new([ @attribute2 ])
    end

    subject { @header.send(method, @other) }

    it { should be_kind_of(Relation::Header) }

    it { should == [ @attribute1, @attribute2 ] }
  end
end
