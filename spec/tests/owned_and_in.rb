
describe ":owned_and_in" do
  
  behaves_like 'box'

  before do
    @user = %x!whoami!.strip
  end

  it 'must return true if file is owned and in group of user' do
    @bx.owned_and_in(@user).call(FILE).should.be == true
  end
  
  it 'must return false if file is owned and in group of wrong user' do
    target = ['root', 'root']
    @bx.owned_and_in('root').call(FILE)
    .should.be == false
  end

end # === describe :owned_and_in
