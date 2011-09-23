require 'minitest/autorun'

def World(*args)
  MiniTest::Mock.new
end

describe 'require step_definitions, should ensure all defined steps are available to Cucumber,' do
  before do
    require 'cucumber-passi/step_definitions'
  end

  it "should require Passi::Helpers" do
    assert Passi::Helpers
  end
end
