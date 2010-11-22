require 'spec_helper'

[ :difference, :- ].each do |method|
  describe "Veritas::Algebra::Difference::Methods##{method}" do
    subject { object.send(method, other) }

    let(:klass)  { Relation                          }
    let(:header) { [ [ :id, Integer ] ]              }
    let(:other)  { klass.new(header, [ [ 2 ] ].each) }
    let(:object) { klass.new(header, [ [ 1 ] ].each) }

    it { should be_kind_of(Algebra::Difference) }

    it 'behaves the same as Array#-' do
      should == (object.to_a - other.to_a)
    end
  end
end
