require File.expand_path('../../../../spec_helper', __FILE__)

[ :offset, :drop ].each do |method|
  describe "Veritas::Relation##{method}" do
    let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
    let(:ordered)  { relation.order { |r| r[:id] }                        }

    subject { ordered.send(method, 1) }

    it { should be_kind_of(Relation::Operation::Offset) }

    it 'behaves the same as Array#drop' do
      should == ordered.to_a.drop(1)
    end
  end
end
