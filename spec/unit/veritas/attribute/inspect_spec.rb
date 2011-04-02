require 'spec_helper'

describe Attribute, '#inspect' do
  subject { object.inspect }

  let(:klass)  { Attribute::Integer }
  let(:object) { klass.new(:id)     }

  it { should be_kind_of(String) }

  it { should == '<Attribute::Integer name: id>' }
end
