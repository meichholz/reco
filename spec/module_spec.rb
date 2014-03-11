require 'spec_helper.rb'

describe Helper do
  describe VERSION do
    it "is a string" do
      expect(VERSION).to be_a_kind_of String
    end
  end
end
  
