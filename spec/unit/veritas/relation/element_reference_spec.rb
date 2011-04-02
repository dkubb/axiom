require 'spec_helper'

describe Relation, '#[]' do
  subject { object[name] }

  let(:klass)     { Relation                          }
  let(:name)      { :id                               }
  let(:attribute) { Attribute::Integer.new(name)      }
  let(:object)    { klass.new([ attribute ], [].each) }

  before do
    object.should be_instance_of(klass)
  end

  it { should equal(attribute) }
end
