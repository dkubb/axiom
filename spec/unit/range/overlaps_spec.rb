require 'spec_helper'

# Definitions and ascii art from ruby mailing list:
#   http://www.ruby-forum.com/topic/98359

describe 'Range#overlaps?' do
  subject { object.overlaps?(other) }

  # self:   |---|
  # other:         |---|
  context 'before' do
    let(:object) { 1..4  }
    let(:other)  { 5..10 }

    it { should be(false) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:          |---|
  # other:  |---|
  context 'after' do
    let(:object) { 5..10 }
    let(:other)  { 1..4  }

    it { should be(false) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:  |---|
  # other:     |---|
  context 'meets' do
    let(:object) { 1..5  }
    let(:other)  { 5..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:      |---|
  # other: |---|
  context 'met_by' do
    let(:object) { 5..10 }
    let(:other)  { 1..5  }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:  |---|
  # other:   |---|
  context 'overlaps' do
    let(:object) { 1..6  }
    let(:other)  { 5..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:    |---|
  # other: |---|
  context 'overlapped_by' do
    let(:object) { 5..10 }
    let(:other)  { 1..6  }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:  |---|
  # other: |-----|
  context 'starts' do
    let(:object) { 1..5 }
    let(:other)  { 1..6 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:  |-----|
  # other: |---|
  context 'started_by' do
    let(:object) { 1..6 }
    let(:other)  { 1..5 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:     |---|
  # other:  |-------|
  context 'during' do
    let(:object) { 5..7  }
    let(:other)  { 1..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:  |-------|
  # other:   |---|
  context 'contains' do
    let(:object) { 1..10 }
    let(:other)  { 5..7  }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:    |---|
  # other: |-----|
  context 'finishes' do
    let(:object) { 5..10 }
    let(:other)  { 1..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:  |-----|
  # other:   |---|
  context 'finished_by' do
    let(:object) { 1..10 }
    let(:other)  { 5..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:   |---|
  # other:  |---|
  context 'equals' do
    let(:object) { 1..10 }
    let(:other)  { 1..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end

  # self:   |---|
  # other:         |---|
  context 'disjoint' do
    let(:object) { 5..10 }
    let(:other)  { 1..4  }

    it { should be(false) }

    it 'is symmetric' do
      should == other.overlaps?(object)
    end
  end
end
