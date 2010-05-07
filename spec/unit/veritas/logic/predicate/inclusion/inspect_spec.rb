require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion#inspect' do
  subject { inclusion.inspect }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:inclusion) { attribute.in([ 1 ])         }

  it { should == "#{attribute.inspect} IN(#{[ 1 ].inspect})" }
end
