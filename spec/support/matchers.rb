# For cookbooks not providing it's own matchers:
# https://github.com/sethvargo/chefspec#writing-custom-matchers
#
# Example:
#
# def create_s3_file(name)
#   ChefSpec::Matchers::ResourceMatcher.new(:s3_file, :create, name)
# end
#
