require 'spec_helper'

[ :difference, :- ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:attribute1) { [ :id,   Integer ]                  }
    let(:attribute2) { [ :name, String  ]                  }
    let(:object)     { described_class.new([ attribute1 ]) }
    let(:other)      { described_class.new([ attribute2 ]) }

    it { should be_kind_of(described_class) }

    it { should == [ attribute1 ] }
  end
end
