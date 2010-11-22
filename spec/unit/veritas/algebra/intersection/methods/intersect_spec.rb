require 'spec_helper'

[ :intersect, :& ].each do |method|
  describe "Veritas::Algebra::Intersection::Methods##{method}" do
    subject { object.send(method, other) }

    let(:klass)  { Relation                          }
    let(:header) { [ [ :id, Integer ] ]              }
    let(:object) { klass.new(header, [ [ 1 ] ].each) }
    let(:other)  { klass.new(header, [ [ 2 ] ].each) }

    it { should be_kind_of(Algebra::Intersection) }

    it 'behaves the same as Array#&' do
      should == (object.to_a & other.to_a)
    end
  end
end
