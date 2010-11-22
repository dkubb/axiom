require 'spec_helper'

describe 'Veritas::Relation#directions' do
  subject { object.directions }

  let(:klass)  { Relation                              }
  let(:body)   { [ [ 1 ] ].each                        }  # use an Enumerator
  let(:object) { klass.new([ [ :id, Integer ] ], body) }

  before do
    object.should be_instance_of(klass)
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should be_empty }
end
