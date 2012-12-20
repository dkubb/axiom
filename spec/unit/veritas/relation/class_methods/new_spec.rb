# encoding: utf-8

require 'spec_helper'

describe Relation, '.new' do
  subject { object.new(header, body) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class                            }

  context 'with an Enumerable responding to #size' do
    let(:body) { [ [ 1 ] ] }

    before do
      body.should respond_to(:size)
    end

    it { should be_instance_of(Relation::Materialized) }

    it { should == body }
  end

  context 'with an Enumerable that returns nil for #size' do
    let(:body) { LazyEnumerable.new([ [ 1 ] ]) }

    before do
      body.should respond_to(:size)
    end

    it { should be_instance_of(object) }

    it { should == [ [ 1 ] ] }
  end

  context 'with an Enumerable that returns Float::INFINITY for #size' do
    let(:body) { klass.new([ [ 1 ] ]) }

    let(:klass) do
      Class.new(SimpleDelegator) do
        def size
          Float::INFINITY
        end
      end
    end

    before do
      body.should respond_to(:size)
    end

    it { should be_instance_of(object) }

    it { should == [ [ 1 ] ] }
  end

  context 'with an Enumerable that does not respond to #size' do
    let(:body) { klass.new }

    let(:klass) do
      Class.new do
        include Enumerable

        def each
          yield [ 1 ]
          self
        end
      end
    end

    before do
      body.should_not respond_to(:size)
    end

    it { should be_instance_of(object) }

    it { should == [ [ 1 ] ] }
  end
end
