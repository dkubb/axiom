# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension::Methods, '#extend' do
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:described_class) { Relation                                                  }
  let(:extensions)      { { :test => function }                                     }
  let(:function)        { lambda { |tuple| 1 }                                      }

  context 'with extensions' do
    subject { object.extend(extensions) }

    it { should be_instance_of(Algebra::Extension) }

    its(:operand) { should equal(object) }

    its(:extensions) { should == { Attribute::Object.new(:test) => function } }
  end

  context 'with a block' do
    subject do
      object.extend do |context|
        extensions.each { |extension| context.add(*extension) }
      end
    end

    it { should be_instance_of(Algebra::Extension) }

    its(:operand) { should equal(object) }

    its(:extensions) { should == { Attribute::Object.new(:test) => function } }
  end
end
