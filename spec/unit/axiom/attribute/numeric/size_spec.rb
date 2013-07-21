# encoding: utf-8

require 'spec_helper'

[:size, :range].each do |method|
  describe Attribute::Numeric, "##{method}" do
    subject { object.send(method) }

    context 'without :size option passed to constructor' do
      let(:object) { described_class.new(:id) }

      it_should_behave_like 'an idempotent method'

      it { should eql(-Float::INFINITY..Float::INFINITY) }
    end

    context 'with a :size option passed to constructor that is inclusive' do
      let(:object) { described_class.new(:id, size: 1..100) }

      it_should_behave_like 'an idempotent method'

      it { should eql(1..100) }
    end

    context 'with a :size option passed to constructor that is exclusive' do
      let(:object) { described_class.new(:id, size: 1...101) }

      it_should_behave_like 'an idempotent method'

      it { should eql(1..100) }
    end
  end
end
