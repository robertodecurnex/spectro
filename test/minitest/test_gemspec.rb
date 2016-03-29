class TestGemspec < Minitest::Test

  def test_included_files
    gem_specification = eval(File.read('spectro.gemspec'))
    expected_files = (['LICENSE', 'README.md', 'bin/spectro'] + FileList['lib/**/*.rb'].to_a + ['spectro.png'])
    assert_equal expected_files, gem_specification.files
  end

end
