# encoding: utf-8

require 'spec_helper'

describe Operation::Binary, '#hash' do
  subject { object.hash }

  let(:described_class) { Class.new { include Operation::Binary } }
  let(:left)            { mock('Left').freeze                     }
  let(:right)           { mock('Right').freeze                    }
  let(:object)          { described_class.new(left, right)        }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ left.hash ^ right.hash }
end
