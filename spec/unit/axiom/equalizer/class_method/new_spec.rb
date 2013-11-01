# encoding: utf-8

require 'spec_helper'

describe Axiom::Equalizer, '.new' do
  let(:object) { described_class }
  let(:name)   { 'User'          }
  let(:klass)  { ::Class.new     }

  before do
    # specify the class #name method
    allow(klass).to receive(:name).and_return(name)
    klass.send(:include, subject)
  end

  context 'with no keys' do
    subject { object.new }

    let(:instance) { klass.new }

    it { should be_instance_of(object) }

    it 'defines #hash and #inspect methods dynamically' do
      expect(subject.public_instance_methods(false).map(&:to_s)).to match_array(%w[hash inspect])
    end

    describe '#eql?' do
      context 'when the objects are equivalent' do
        let(:other) { klass.new }

        it { expect(instance.eql?(other)).to be(true) }
      end

      context 'when the objects are different' do
        let(:other) { double('other') }

        it { expect(instance.eql?(other)).to be(false) }
      end
    end

    describe '#==' do
      context 'when the objects are equivalent' do
        let(:other) { klass.new }

        it { expect(instance == other).to be(true) }
      end

      context 'when the objects are different' do
        let(:other) { double('other') }

        it { expect(instance == other).to be(false) }
      end
    end

    describe '#hash' do
      it { expect(instance.hash).to eql(klass.hash) }

      it 'memoizes the hash code' do
        expect(instance.hash).to eql(instance.memoized(:hash))
      end
    end

    describe '#inspect' do
      it { expect(instance.inspect).to eql('#<User>') }
    end
  end

  context 'with keys' do
    subject { object.new(*keys) }

    let(:keys)       { [:first_name].freeze  }
    let(:first_name) { 'John'                }
    let(:instance)   { klass.new(first_name) }

    let(:klass) do
      ::Class.new do
        attr_reader :first_name

        def initialize(first_name)
          @first_name = first_name
        end
      end
    end

    it { should be_instance_of(object) }

    it 'defines #hash and #inspect methods dynamically' do
      expect(subject.public_instance_methods(false).map(&:to_s)).to match_array(%w[hash inspect])
    end

    describe '#eql?' do
      context 'when the objects are equivalent' do
        let(:other) { klass.new(first_name) }

        it { expect(instance.eql?(other)).to be(true) }
      end

      context 'when the objects are different' do
        let(:other) { double('other') }

        it { expect(instance.eql?(other)).to be(false) }
      end
    end

    describe '#==' do
      context 'when the objects are equivalent' do
        let(:other) { klass.new(first_name) }

        it { expect(instance == other).to be(true) }
      end

      context 'when the objects are different' do
        let(:other) { double('other') }

        it { expect(instance == other).to be(false) }
      end
    end

    describe '#hash' do
      it { expect(instance.hash).to eql(klass.hash ^ first_name.hash) }

      it 'memoizes the hash code' do
        expect(instance.hash).to eql(instance.memoized(:hash))
      end
    end

    describe '#inspect' do
      it { expect(instance.inspect).to eql('#<User first_name="John">') }
    end
  end
end
