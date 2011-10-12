
describe ":have_permissions" do
  
  behaves_like 'box'

  it 'must return true if file has the desired mode bits' do
    @bx.have_permissions('-rw-r--r--').call(FILE).should.be == true
  end
  
  it 'must return false if file does not have the desired mode bits' do
    target = 'drwxr--r--'
    @bx.have_permissions(target).call(FILE)
    .should.be == false
  end

end # === describe :have_permissions
