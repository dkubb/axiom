# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension::Methods, '#extend' do
  let(:object)          { described_class.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
  let(:described_class) { Relation                                                                 }
  let(:extensions)      { { :test => function }                                                    }
  let(:function)        { object[:id]                                                              }

  context 'with extensions' do
    subject { object.extend(extensions) }

    it { should be_instance_of(Algebra::Extension) }

    its(:operand) { should equal(object) }

    its(:extensions) { should == { Attribute::Object.new(:test) => function } }
  end

  context 'with a block' do
    subject do
      object.extend do |context|
        context.add(:test, context[:id])
      end
    end

    it { should be_instance_of(Algebra::Extension) }

    its(:operand) { should equal(object) }

    its(:extensions) { should == { Attribute::Integer.new(:test) => function } }
  end
end
