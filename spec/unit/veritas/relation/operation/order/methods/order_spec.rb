# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Methods, '#order' do
  let(:described_class) { Relation                                                         }
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }

  before do
    @original, $stderr = $stderr, StringIO.new
  end

  after do
    $stderr = @original
  end

  context 'with no arguments' do
    subject { object.order }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == object.header }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == object.to_a.sort_by { |tuple| tuple[:id] }
    end

    it 'warns with a deprecation message' do
      expect { subject }.to change { $stderr.string.chomp }.
        from(nil).
        to('Veritas::Relation#order is deprecated and will be removed from Veritas 0.0.6')
    end
  end

  context 'with a block' do
    subject { object.order(&block) }

    let(:block) { lambda { |relation| [ relation[:id].desc ] } }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == block.call(object) }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == object.to_a.sort_by { |tuple| tuple[:id] }.reverse
    end

    it 'warns with a deprecation message' do
      expect { subject }.to change { $stderr.string.chomp }.
        from(nil).
        to('Veritas::Relation#order is deprecated and will be removed from Veritas 0.0.6')
    end
  end
end
