require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the GetGoingHelper. For example:
#
# describe GetGoingHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe GetGoingHelper do
  describe "#summary_page_for_category" do
    it "should have a path for each symbol" do
      User.default_categories_hash.keys.each do |k|
        path = summary_page_for_category(k)
        expect(path).not_to eq("")
      end
    end

    it "should reject bad symbols" do
      [:Xfacebook, :abc].each do |k|
        expect { summary_page_for_category(k) }.to raise_error(RuntimeError, /not found/)
      end
    end
  end
end
