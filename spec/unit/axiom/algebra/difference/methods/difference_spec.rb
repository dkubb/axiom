# encoding: utf-8

require 'spec_helper'

[ :difference, :- ].each do |method|
  describe Algebra::Difference::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Relation                                                   }
    let(:header)          { [ [ :id, Integer ] ]                                       }
    let(:other)           { described_class.new(header, LazyEnumerable.new([ [ 2 ] ])) }
    let(:object)          { described_class.new(header, LazyEnumerable.new([ [ 1 ] ])) }

    it { should be_instance_of(Algebra::Difference) }

    it 'behaves the same as Array#-' do
      should == object.to_a - other.to_a
    end
  end
end
