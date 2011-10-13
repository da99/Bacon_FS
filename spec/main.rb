
require File.expand_path('spec/helper')
require 'Bacon_FS'

FOLDER = "/tmp/BACON_FS"
%x! mkdir -p #{FOLDER} !

FILE = "#{FOLDER}/story.txt"

%x! echo "I awoke to dawn." > #{FILE}!

at_exit {
  %x! rm -rf #{FOLDER} !
}

class Box
  include Bacon_FS::DSL
end # === class

shared 'box' do

  before do
    @bx = Box.new
  end

end # === shared


Dir.glob('spec/tests/*.rb').each { |file|
  require File.expand_path(file.sub('.rb', '')) if File.file?(file)
}
