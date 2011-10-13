require "Bacon_FS/version"

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

module Bacon_FS

  module DSL

    # Returns: Permissions_Array: %w! drwxr-xr-x user group !
    def permissions raw_path
      path      = File.expand_path(raw_path)
      dir       = File.dirname(path.strip)
      base_name = File.basename(path)
      pattern   = %r!\d+:\d+\s#{base_name}(\s|$)!
      raise "Invalid character in path: #{dir}" if dir[/\s/]
      
      results   = %x! ls -al #{dir} !.split("\n").grep(pattern)

      raise "Too many ls listings for #{raw_path}: #{results.inspect}" if results.size > 1
      raise "No ls listings for #{raw_path}: #{results.inspect}" if results.size != 1

      pieces = results.first.split
			[ pieces[0], pieces[2], pieces[3] ]
    end
    
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
      }
    end

    def have_permissions str
      lambda { |obj|
        actual  = permissions(obj).first
        desired = str
        actual == desired
      }
    end

    def directory
      lambda { |obj|
        File.directory?(obj)
      }
    end

    def file
      lambda { |obj|
        File.file?(obj)
      }
    end


  end # === module

end # === class 
