# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#eql?' do
  subject { object.eql?(other) }

  let(:operand)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])    }
  let(:summarize_by) { operand.project([])                                     }
  let(:summarizers)  { { :count => lambda { |acc, tuple| acc.to_i + 1 } }      }
  let(:object)       { described_class.new(operand, summarize_by, summarizers) }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(operand, operand.project([]), summarizers) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand)      { Relation.new([ [ :id, Integer ] ], [ [ 3 ] ])                             }
    let(:other_summarize_by) { summarize_by                                                              }
    let(:other_summarizers)  { summarizers                                                               }
    let(:other)              { described_class.new(other_operand, other_summarize_by, other_summarizers) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different summarize_by' do
    let(:other_operand)      { operand                                                                   }
    let(:other_summarize_by) { operand.project([]).sort_by {}                                            }
    let(:other_summarizers)  { summarizers                                                               }
    let(:other)              { described_class.new(other_operand, other_summarize_by, other_summarizers) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having different summarizers' do
    let(:other_operand)      { operand                                                                   }
    let(:other_summarize_by) { summarize_by                                                              }
    let(:other_summarizers)  { {}                                                                        }
    let(:other)              { described_class.new(other_operand, other_summarize_by, other_summarizers) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
