require 'spec_helper'

[ :union, :| ].each do |method|
  describe Algebra::Union::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Relation                                    }
    let(:header)          { [ [ :id, Integer ] ]                        }
    let(:other)           { described_class.new(header, [ [ 2 ] ].each) }
    let(:object)          { described_class.new(header, [ [ 1 ] ].each) }

    it { should be_kind_of(Algebra::Union) }

    it 'behaves the same as Array#|' do
      should == (object.to_a | other.to_a)
    end
  end
end
