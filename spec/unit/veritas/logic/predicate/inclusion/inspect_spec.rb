require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion#inspect' do
  subject { inclusion.inspect }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:inclusion) { attribute.include([ 1 ])    }

  it { should == "#{attribute.inspect} IN(#{[ 1 ].inspect})" }
end
