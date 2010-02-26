require File.expand_path('../../../../spec_helper', __FILE__)

[ :product, :* ].each do |method|
  describe "Veritas::Relation##{method}" do
    before do
      @relation = Relation.new([ [ :id,   Integer ] ], [ [ 1          ] ])
      @other    = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
    end

    subject { @relation.send(method, @other) }

    it { should be_kind_of(Algebra::Product) }
  end
end
