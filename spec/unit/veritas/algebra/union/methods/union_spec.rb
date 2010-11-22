require 'spec_helper'

[ :union, :| ].each do |method|
  describe "Veritas::Algebra::Union::Methods##{method}" do
    subject { object.send(method, other) }

    let(:klass)  { Relation                          }
    let(:header) { [ [ :id, Integer ] ]              }
    let(:other)  { klass.new(header, [ [ 2 ] ].each) }
    let(:object) { klass.new(header, [ [ 1 ] ].each) }

    it { should be_kind_of(Algebra::Union) }

    it 'behaves the same as Array#|' do
      should == (object.to_a | other.to_a)
    end
  end
end
