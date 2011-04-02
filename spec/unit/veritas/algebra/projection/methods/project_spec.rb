require 'spec_helper'

describe Algebra::Projection::Methods, '#project' do
  subject { object.project(attributes) }

  let(:described_class) { Relation                                                                                 }
  let(:attributes)      { [ :id ]                                                                                  }
  let(:object)          { described_class.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ].each) }

  it { should be_kind_of(Algebra::Projection) }

  its(:header) { should == [ [ :id, Integer ] ] }

  it 'behaves the same as Enumerable#map with Tuple#[]' do
    should == object.map { |tuple| [ tuple[:id] ] }
  end
end
