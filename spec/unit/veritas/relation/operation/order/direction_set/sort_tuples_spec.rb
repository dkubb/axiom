# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#sort_tuples' do
  subject { object.sort_tuples(relation) }

  let(:header)   { [ [ :id, Integer ], [ :name, String ] ]                      }
  let(:body)     { [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ] ] }
  let(:relation) { Relation.new(header, body)                                   }
  let(:object)   { described_class.new(header)                                  }

  context 'sorted with ascending id and descending name' do
    let(:object) { described_class.new([ relation[:id].asc, relation[:name].desc ]) }

    it { should be_instance_of(Array) }

    it { should == [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ] }
  end

  context 'sorted with ascending id and ascending name' do
    let(:object) { described_class.new([ relation[:id].asc, relation[:name].asc ]) }

    it { should be_instance_of(Array) }

    it { should == [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ] ] }
  end

  context 'sorted with descending id and ascending name' do
    let(:object) { described_class.new([ relation[:id].desc, relation[:name].asc ]) }

    it { should be_instance_of(Array) }

    it { should == [ [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ], [ 1, 'Dan Kubb' ] ] }
  end

  context 'sorted with descending id and descending name' do
    let(:object) { described_class.new([ relation[:id].desc, relation[:name].desc ]) }

    it { should be_instance_of(Array) }

    it { should == [ [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 1, 'Dan Kubb' ] ] }
  end
end
