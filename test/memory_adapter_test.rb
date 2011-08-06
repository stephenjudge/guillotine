require File.expand_path('../helper', __FILE__)

class MemoryAdapterTest < Guillotine::TestCase
  def setup
    @db = Guillotine::Adapters::MemoryAdapter.new
  end

  def test_adding_a_link_returns_code
    code = @db.add 'abc'
    assert_equal 'abc', @db.find(code)
  end

  def test_adding_duplicate_link_returns_same_code
    code = @db.add 'abc'
    assert_equal code, @db.add('abc')
  end
end