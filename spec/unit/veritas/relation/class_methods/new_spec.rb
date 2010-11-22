require 'spec_helper'

describe 'Veritas::Relation.new' do
  subject { object.new(header, body) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { Relation                                   }

  context 'with an Enumerable responding to #size' do
    let(:body) { [ [ 1 ] ] }

    before do
      body.should respond_to(:size)
    end

    it { should be_kind_of(Relation::Materialized) }

    it { should == body }
  end

  context 'with an Enumerable that does not respond to #size' do
    let(:body) { [ [ 1 ] ].each }  # use an Enumerator

    before do
      body.should_not respond_to(:size)
    end

    it { should be_kind_of(object) }

    it { should == [ [ 1 ] ] }
  end
end
