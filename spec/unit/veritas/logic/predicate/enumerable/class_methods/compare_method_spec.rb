require 'spec_helper'

describe 'Veritas::Logic::Predicate::Enumerable.compare_method' do
  subject { object.compare_method(enumerable) }

  let(:object) { Logic::Predicate::Enumerable }

  context 'the enumerable is a Range' do
    let(:enumerable) { 1..2 }

    it { should == :cover? }
  end

  context 'the enumerable is an Array' do
    let(:enumerable) { [ 1, 2 ] }

    it { should == :include? }
  end
end
