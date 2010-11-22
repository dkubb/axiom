require 'spec_helper'

describe 'Veritas::Attribute#name' do
  subject { object.name }

  let(:klass)  { Attribute::Integer }
  let(:name)   { :id                }
  let(:object) { klass.new(name)    }

  it { should == name }
end
