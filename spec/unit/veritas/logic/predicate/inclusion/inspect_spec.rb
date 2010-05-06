require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion#inspect' do
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:inclusion) { attribute.in([ 1 ])         }

  subject { inclusion.inspect }

  it { should == "#{attribute.inspect} IN(#{[ 1 ].inspect})" }
end
