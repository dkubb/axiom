require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#to_set' do
  before do
    @tuple = mock('Tuple')
    @body  = Relation::Body.new(mock('Header'), [ @tuple ])
  end

  subject { @body.to_set }

  it { should be_instance_of(Set) }

  it { should == Set[ @tuple ] }
end
