require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::CombineOperation.combine_tuples' do
  subject { CombineOperationSpecs::Object.combine_tuples([ [ 1 ] ], [ 2 ]) }

  it { should == [ [ 1, 2 ] ] }
end
