require File.expand_path('../../../spec_helper', __FILE__)

# Definitions and ascii art from ruby mailing list:
#   http://www.ruby-forum.com/topic/98359

describe 'Range#overlaps?' do
  subject { range.overlaps?(other) }

  # self:   |---|
  # other:         |---|
  describe 'before' do
    let(:range) { 5..10 }
    let(:other) { 1..4  }

    it { should be(false) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:          |---|
  # other:  |---|
  describe 'after' do
    let(:range) { 5..10  }
    let(:other) { 11..15 }

    it { should be(false) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:  |---|
  # other:     |---|
  describe 'meets' do
    let(:range) { 5..10  }
    let(:other) { 10..15 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:      |---|
  # other: |---|
  describe 'met_by' do
    let(:range) { 5..10 }
    let(:other) { 1..5  }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:  |---|
  # other:   |---|
  describe 'overlaps' do
    let(:range) { 5..10 }
    let(:other) { 9..15 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:    |---|
  # other: |---|
  describe 'overlapped_by' do
    let(:range) { 5..10 }
    let(:other) { 1..6  }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:  |---|
  # other: |-----|
  describe 'starts' do
    let(:range) { 1..5 }
    let(:other) { 1..6 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:  |-----|
  # other: |---|
  describe 'started_by' do
    let(:range) { 1..6 }
    let(:other) { 1..5 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:    |---|
  # other: |-----|
  describe 'finishes' do
    let(:range) { 5..10 }
    let(:other) { 1..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:  |-----|
  # other:   |---|
  describe 'finished_by' do
    let(:range) { 1..10 }
    let(:other) { 5..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:     |---|
  # other:  |-------|
  describe 'during' do
    let(:range) { 5..7  }
    let(:other) { 1..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:  |-------|
  # other:   |---|
  describe 'contains' do
    let(:range) { 1..10 }
    let(:other) { 5..7  }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:   |---|
  # other:  |---|
  describe 'equals' do
    let(:range) { 1..10 }
    let(:other) { 1..10 }

    it { should be(true) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end

  # self:   |---|
  # other:         |---|
  describe 'disjoint' do
    let(:range) { 5..10 }
    let(:other) { 1..4  }

    it { should be(false) }

    it 'is symmetric' do
      should == other.overlaps?(range)
    end
  end
end
