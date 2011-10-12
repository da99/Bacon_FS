
describe ":a_directory" do
  
  behaves_like 'box'

  it 'must return true if directory exists' do
    @bx.directory.call(FOLDER).should.be == true
  end

  it 'must return false if directory is a file' do
    @bx.directory.call(FILE)
    .should.be == false
  end

end # === describe :a_directory
