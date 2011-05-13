# encoding: utf-8

require 'spec_helper'

[ :intersect, :& ].each do |method|
  describe Algebra::Intersection::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Relation                                    }
    let(:header)          { [ [ :id, Integer ] ]                        }
    let(:object)          { described_class.new(header, [ [ 1 ] ].each) }
    let(:other)           { described_class.new(header, [ [ 2 ] ].each) }

    it { should be_kind_of(Algebra::Intersection) }

    it 'behaves the same as Array#&' do
      should == (object.to_a & other.to_a)
    end
  end
end
