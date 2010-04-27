require File.expand_path('../../../../spec_helper', __FILE__)

[ :difference, :- ].each do |method|
  describe "Veritas::Relation##{method}" do
    before do
      header = [ [ :id, Integer ] ]

      @relation = Relation.new(header, [ [ 1 ] ])
      @other    = Relation.new(header, [ [ 2 ] ])
    end

    subject { @relation.send(method, @other) }

    it { should be_kind_of(Algebra::Difference) }

    it 'behaves the same as Array#-' do
      should == (@relation.to_a - @other.to_a)
    end
  end
end
