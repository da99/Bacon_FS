
describe "have_key" do
  
  behaves_like 'box'

  it 'must return true if array has desired key' do
    @bx.have_key('KEY').call('KEY'=>'master')
    .should.be == true
  end

  it 'must return false if array has desired key' do
    @bx.have_key('KEY').call('GOZER'=>'master')
    .should.be == false
  end

end # === describe have_key
