require 'RubyUnit'

module RubyUnitTests
  #
  # Test Case for the RubyUnit module
  #
  class TC_RubyUnit < RubyUnit::TestCase
    #
    # Verify that the VERSION constant is defined in the RubyUnit module
    #
    def versionDefinedTest
      assertConstDefined RubyUnit, 'VERSION', 'Version must be defined in RubyUnit::VERSION'
    end
  end
end