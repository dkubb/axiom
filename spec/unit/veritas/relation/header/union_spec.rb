require 'spec_helper'

[ :union, :| ].each do |method|
  describe Relation::Header, "##{method}" do
    subject { object.send(method, other) }

    let(:attribute1) { [ :id,   Integer ]                  }
    let(:attribute2) { [ :name, String  ]                  }
    let(:other)      { described_class.new([ attribute2 ]) }
    let(:object)     { described_class.new([ attribute1 ]) }

    it { should be_kind_of(described_class) }

    it { should == [ attribute1, attribute2 ] }
  end
end
