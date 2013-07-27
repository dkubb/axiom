# encoding: utf-8

require 'spec_helper'

# Test that Relation::Variable is thread-safe

describe Relation::Variable do
  subject { described_class.new(relation) }

  let(:object)       { described_class.new(relation)  }
  let(:relation)     { Relation.new([[:id, Integer]]) }
  let(:thread_count) { 10                             }
  let(:per_thread)   { 10                             }

  # Perform operation in parallel within multiple threads
  def parallel(operation)
    relvar = subject
    thread_count.times.map do |index|
      offset = index * per_thread
      Thread.new do
        per_thread.times do |id|
          relvar.public_send(operation, [[id + offset]])
        end
      end
    end.each(&:join)
  end

  describe '#insert' do
    it 'is thread-safe' do
      parallel(:insert)
      expect(subject.count).to be(thread_count * per_thread)
    end
  end

  describe '#delete' do
    before do
      parallel(:insert)
    end

    it 'is thread-safe' do
      parallel(:delete)
      expect(subject).to be_empty
    end
  end
end
