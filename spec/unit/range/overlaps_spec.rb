require File.expand_path('../../../spec_helper', __FILE__)

# Definitions and ascii art from ruby mailing list:
#   http://www.ruby-forum.com/topic/98359

describe 'Range#overlaps?' do
  subject { @range.overlaps?(@other) }

  # self:   |---|
  # other:         |---|
  describe 'before' do
    before do
      @range = 5..10
      @other = 1..4
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:          |---|
  # other:  |---|
  describe 'after' do
    before do
      @range = 5..10
      @other = 11..15
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:  |---|
  # other:     |---|
  describe 'meets' do
    before do
      @range = 5..10
      @other = 10..15
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:      |---|
  # other: |---|
  describe 'met_by' do
    before do
      @range = 5..10
      @other = 1..5
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:  |---|
  # other:   |---|
  describe 'overlaps' do
    before do
      @range = 5..10
      @other = 9..15
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:    |---|
  # other: |---|
  describe 'overlapped_by' do
    before do
      @range = 5..10
      @other = 1..6
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:  |---|
  # other: |-----|
  describe 'starts' do
    before do
      @range = 1..5
      @other = 1..6
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:  |-----|
  # other: |---|
  describe 'started_by' do
    before do
      @range = 1..6
      @other = 1..5
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:    |---|
  # other: |-----|
  describe 'finishes' do
    before do
      @range = 5..10
      @other = 1..10
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:  |-----|
  # other:   |---|
  describe 'finished_by' do
    before do
      @range = 1..10
      @other = 5..10
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:     |---|
  # other:  |-------|
  describe 'during' do
    before do
      @range = 5..7
      @other = 1..10
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:  |-------|
  # other:   |---|
  describe 'contains' do
    before do
      @range = 1..10
      @other = 5..7
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:   |---|
  # other:  |---|
  describe 'equals' do
    before do
      @range = 1..10
      @other = 1..10
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end

  # self:   |---|
  # other:         |---|
  describe 'disjoint' do
    before do
      @range = 5..10
      @other = 1..4
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.overlaps?(@range)
    end
  end
end
