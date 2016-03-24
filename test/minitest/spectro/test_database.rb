class TestSpectro < Minitest::Test

  class TestDatabase < Minitest::Test

    def setup
      @database = Spectro::Database.instance
      @database.reset_index()
    end

    def test_class_fetch
      Dir.chdir('test/files') do
        assert_equal @database.fetch('sample.rb', 'hello', [:name]), Spectro::Database.fetch('sample.rb', 'hello', [:name])
      end
    end

    def test_fetch
      λ = nil
      Dir.chdir('test/files') do
        λ = @database.fetch('sample.rb', 'hello', [:name])
      end
      assert_instance_of Proc, λ
      assert λ.lambda?, 'Spectro::Database#fetch was expected to return a lambda type of Proc but it did not.'
      assert_equal 'Say Hello to Test', λ.call('Test')
    end

    def test_fetch_undefined_method
      λ = nil
      Dir.chdir('test/files') do
        λ = @database.fetch('sample.rb', 'unknown', [])
      end
      assert_equal nil, λ
    end

    def test_fetch_undefined_file
      λ = nil
      Dir.chdir('test/files') do
        λ = @database.fetch('unknown.rb', 'sum', [:name])
      end
      assert_equal nil, λ
    end

    def test_index
      Dir.chdir('test/files') do
        @database.index
      end
    end

    def test_index_on_unitialized_project
      Dir.chdir('test/uninitialized_project') do
        @database.index
      end
    end

  end

end

