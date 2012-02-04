require 'minitest/autorun'

require File.expand_path('../lib/cucumber-passi/support/model_step_helper', File.dirname(__FILE__))

describe 'Passi::StepHelpers' do
  before do
    class CUT #Class Under Test
      extend Passi::StepHelpers
    end
  end

  describe 'generate_model,' do
    describe "with no attributes," do
      it "should generate the model using a Factory" do
        #TODO: use the pattern like a before filter
        Factory = MiniTest::Mock.new
        Factory.expect(:create, nil, [:any_model, {}])
        CUT.generate_model(:any_model)
      end
    end

    describe "with attributes" do
      it "should pass those attributes to Factory (with stringified keys)" do
        Factory = MiniTest::Mock.new
        Factory.expect(:create, nil, [:any_model, {'title' => 'TITLE'}])
        CUT.generate_model(:any_model, :title => 'TITLE')
      end
    end

#    context "with :tags association in attributes" do
#      subject { generate_model(:email, {:tags => 'TAG1, TAG2'}) }
#
#      it { should have(2).tags }
#      it { subject.tags.collect(& :title).should include('TAG1') }
#      it { subject.tags.collect(& :title).should include('TAG2') }
#    end
#
#    context "with :folders association in attributes" do
#      subject { generate_model(:project, {:folders => 'FOLDER1, FOLDER2'}) }
#
#      it { should have(2).folders }
#      it { subject.folders.collect(& :folder_name).should include('FOLDER1') }
#      it { subject.folders.collect(& :folder_name).should include('FOLDER2') }
#    end

  end
end
