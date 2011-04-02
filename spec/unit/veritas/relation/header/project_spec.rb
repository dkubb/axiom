require 'spec_helper'

describe Relation::Header, '#project' do
  subject { object.project(attributes) }

  let(:klass)      { Relation::Header                                   }
  let(:attributes) { [ :id ]                                            }
  let(:object)     { klass.new([ [ :id, Integer ], [ :name, String ] ]) }

  it { should be_kind_of(klass) }

  it { should == [ [ :id, Integer ] ] }
end
