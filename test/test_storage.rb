class TestStorage < Test::Unit::TestCase
  
  def setup
    @storage = Credstore::Storage.new("./tmp")
    @teststring = "Hello World"
    @teststring2 = "Goodbye"
  end
  
  def teardown
  end
  
  def test_read_and_write
    @storage.write_key("test", "test string")
    assert_equal @storage.read_key("test"), "test string"
  end
  
  def test_method_missing
    @storage.test_string = @teststring
    assert_equal @storage.test_string, @teststring
    assert_not_equal @storage.store.transaction {@storage.store[:test_string]}, @teststring
    @storage.test_string = @teststring2
    assert_equal @storage.test_string, @teststring2
    assert_not_equal @storage.test_string, @teststring
    @storage.test_string = nil
    assert_nil @storage.test_string
  end

end