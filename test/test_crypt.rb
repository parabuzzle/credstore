class TestCrypt < Test::Unit::TestCase
  
  def setup
    Credstore::Crypt.generate_keys(2048, "#{$LIB_BASE_DIR}/tmp/", "id_rsa.pub", "id_rsa")
    @crypt_with_private_key = Credstore::Crypt.new("#{$LIB_BASE_DIR}/tmp", "id_rsa.pub", "id_rsa")
    @crypt_without_private_key = Credstore::Crypt.new("#{$LIB_BASE_DIR}/tmp")
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