require 'spec_helper'

[ :limit, :take ].each do |method|
  describe "Veritas::Relation::Operation::Limit::Methods##{method}" do
    subject { ordered.send(method, 1) }

    let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
    let(:ordered)  { relation.order { |r| r[:id] }                        }

    it { should be_kind_of(Relation::Operation::Limit) }

    it 'behaves the same as Array#take' do
      should == ordered.to_a.take(1)
    end
  end
end
