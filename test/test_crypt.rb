class TestCrypt < Test::Unit::TestCase
  
  def setup
    
    setup_hash={:length=>2048, :keys_dir=>"#{$LIB_BASE_DIR}/tmp/", :public_key=>"id_rsa.pub", :private_key=>"id_rsa"}
    Credstore::Crypt.generate_keys(setup_hash)
    
    no_private_key={:keys_dir=>"#{$LIB_BASE_DIR}/tmp/", :public_key=>"id_rsa.pub", :private_key=>nil}
    @crypt_without_private_key = Credstore::Crypt.new(no_private_key)
    
    with_private_key={:keys_dir=>"#{$LIB_BASE_DIR}/tmp/", :public_key=>"id_rsa.pub", :private_key=>"id_rsa"}
    @crypt_with_private_key = Credstore::Crypt.new(with_private_key)
  end
  
  def teardown
    
  end
  
  def test_encryption
    string = @crypt_with_private_key.encrypt_string("hello world")
    assert_equal @crypt_with_private_key.decrypt_string(string), "hello world"
    assert_not_equal @crypt_with_private_key.decrypt_string(string), "hello world2"
    string_from_public = @crypt_without_private_key.encrypt_string("hello world2")
    assert_equal @crypt_with_private_key.decrypt_string(string_from_public), "hello world2"
    assert_not_equal @crypt_with_private_key.decrypt_string(string_from_public), "hello world"
    assert_nil @crypt_with_private_key.decrypt_string(nil)
  end

end