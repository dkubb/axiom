require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion#inspect' do
  subject { inclusion.inspect }

  let(:klass)     { Logic::Predicate::Inclusion }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:inclusion) { klass.new(attribute, [ 1 ]) }

  it { should == "#{attribute.inspect} included in #{[ 1 ].inspect}" }
end
