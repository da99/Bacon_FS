require "Bacon_FS/version"

require 'Shell_Helpers'

class Should
  
  class Exposed
    def initalize shoulda
      @negated = shoulda.instance_variable_get(:@negated)
      @object  = shoulda.instance_variable_get(:@object)
    end
  end
  
  alias_method :be_not_array, :be
  def be *raw_args, &blok
    
    args = raw_args.flatten
    
    if !block_given? && args.size == 2 && args.first.is_a?(Proc) && args.last.is_a?(Proc)
      desc = args.first.call(Exposed.new self)
      blok = args.last
      return be_not_array( desc, &blok )
    end

    be_not_array(*raw_args, &blok)
  end

end # === class Should

class Bacon_FS_Matchers

  module DSL

    include Shell_Helpers::DSL

    def have_key key

      matcher = lambda { |obj|
        obj.has_key?(key)
      }
      
    end

    def file_containing msg, show_contents = false
      lambda { |obj|
        if not File.file?(obj)
          should.flunk "Not a file: #{obj}"
        end

        contents = File.read(obj)
        !!contents[msg]
      }
    end

    def owned_and_in( user )
      lambda { |obj|
        actual = permissions(obj)[1,2]
        desired = [ user, user ]
        actual == desired
        # should.flunk "#{obj.inspect} owner/group: #{actual} Should be: #{desired.inspect}"
      }
    end

    def have_permissions str
      lambda { |obj|
        actual  = permissions(obj).first
        desired = str
        actual == desired
        # should.flunk "#{obj.inspect} permissions: #{actual} Should be: #{desired}"

      }
    end

    def directory
      lambda { |obj|
        File.directory?(obj)
        # should.flunk "#{obj.inspect} is not a directory."
      }
    end

    def file
      lambda { |obj|
        File.file?(obj)
        # should.flunk "#{obj.inspect} is not a file."
      }
    end


  end # === module

end # === class 
