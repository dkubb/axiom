require 'spec_helper'

describe 'Veritas::Algebra::Projection::Methods#remove' do
  subject { object.remove(attributes) }

  let(:klass)      { Relation                                                                       }
  let(:attributes) { [ :id ]                                                                        }
  let(:object)     { klass.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ].each) }

  it { should be_kind_of(Algebra::Projection) }

  its(:header) { should == [ [ :name, String ] ] }

  it 'behaves the same as Enumerable#map with Tuple#[]' do
    should == object.map { |tuple| [ tuple[:name] ] }
  end
end
