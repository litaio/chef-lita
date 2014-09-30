#
# Cookbook Name:: lita
# Libraries:: typecast
#

# LitaHelpers
module LitaHelpers
  # Try hard to find a correct type
  def typecast(obj)
    # This could definitely be normalized down to a simpler flow, but I keep
    # thinking I'm going to find some exception that needs the granular detail
    if obj.is_a?(Hash) || obj.is_a?(Array)
      # hashes and arrays will be inspected to display properly
      obj.inspect
    elsif obj.is_a?(Fixnum)    || obj.is_a?(Float)      ||
          obj.is_a?(TrueClass) || obj.is_a?(FalseClass)
      # these are just plain (that is obj.to_s does what we want)
      obj
    elsif obj.is_a?(Symbol)
      # symbols should remain symbols
      ":#{obj}"
    else
      # must be a string so let's try to convert to a ruby type
      case obj
      when /^:/
        # found symbol
        obj
      when /^\{/
        # found hash
        obj
      when /^\[/
        # found array
        obj
      when /^true$|^false$/
        # found boolean
        obj
      when /^[0-9]+\.[0-9]+$/
        # found Float
        obj
      when /^[0-9]+$/
        # found Fixnum
        obj
      else
        # leave it as a string
        "\"#{obj}\""
      end
    end
  end
end
