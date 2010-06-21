require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#hash' do
  subject { complement.hash }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:operand)    { attribute.eq(1)                            }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  it { should be_kind_of(Integer) }

  it { should == operand.hash }

  it_should_behave_like 'an idempotent method'
end
