require File.expand_path('../../../../../../spec_helper', __FILE__)

[ :intersect, :& ].each do |method|
  describe "Veritas::Algebra::Intersection::Methods##{method}" do
    subject { relation.send(method, other) }

    let(:header)   { [ [ :id, Integer ] ]            }
    let(:relation) { Relation.new(header, [ [ 1 ] ]) }
    let(:other)    { Relation.new(header, [ [ 2 ] ]) }

    it { should be_kind_of(Algebra::Intersection) }

    it 'behaves the same as Array#&' do
      should == (relation.to_a & other.to_a)
    end
  end
end
