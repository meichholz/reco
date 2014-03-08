require 'spec_helper.rb'

describe WML do
  describe WML::VERSION do
    it "is a string" do
      expect(WML::VERSION).to be_a_kind_of String
    end
  end
end
  
