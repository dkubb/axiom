require 'spec_helper'

describe Attribute, '#name' do
  subject { object.name }

  let(:klass)  { Attribute::Integer }
  let(:name)   { :id                }
  let(:object) { klass.new(name)    }

  it { should == name }
end
