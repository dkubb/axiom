# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection::Methods, '#project' do
  subject { object.project(attributes) }

  let(:described_class) { Relation                                                                                                }
  let(:attributes)      { [ :id ]                                                                                                 }
  let(:object)          { described_class.new([ [ :id, Integer ], [ :name, String ] ], LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ])) }

  it { should be_instance_of(Algebra::Projection) }

  its(:header) { should == [ [ :id, Integer ] ] }

  it 'behaves the same as Enumerable#map with Tuple#[]' do
    should == object.map { |tuple| [ tuple[:id] ] }
  end
end
