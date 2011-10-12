require File.expand_path('spec/spec_helper')

FOLDER = "/tmp/BACON_FS_MATCHERS"
%x! mkdir -p #{FOLDER} !

FILE = "#{FOLDER}/story.txt"

%x! echo "I awoke to dawn." > #{FILE}!

at_exit {
  %x! rm -rf #{FOLDER} !
}

class Box
  include Bacon_FS_Matchers::DSL
end # === class

shared 'box' do

  before do
    @bx = Box.new
  end

end # === shared

Dir.glob('spec/tests/*.rb').each { |file|
  ruby_file = file.sub(%r!\.rb!, '')
  require File.expand_path(ruby_file)
}

