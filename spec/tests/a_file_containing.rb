
describe ":a_file_containing" do
  
  behaves_like 'box'

  it 'must return true if file contains the String.' do
    @bx.file_containing('dawn').call(FILE).should.be == true
  end

  it 'must return false if file does not contains the String.' do
    @bx.file_containing('Wallace Thornhill').call(FILE)
    .should.be == false
  end

end # === describe :a_file_containing
