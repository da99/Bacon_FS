

describe ":a_file" do
  
  behaves_like 'box'

  it 'must return true if file exists' do
    @bx.file.call(FILE).should.be == true
  end

  it 'must return false if file is a directory' do
    @bx.file.call(FOLDER)
    .should.be == false
  end

end # === describe :a_file
