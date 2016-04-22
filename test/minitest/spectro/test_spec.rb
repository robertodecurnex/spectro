require_relative 'spec/test_parser'
require_relative 'spec/test_rule'
require_relative 'spec/test_signature'

class TestSpectro < Minitest::Test

  class TestSpec < Minitest::Test

    def setup
      @rule = Spectro::Spec::Rule.new([1, 2], 3)
      @signature = Spectro::Spec::Signature.new('local_name', ['Fixnum'], 'Fixnum')
      @description = "Random Description In Here"
      @tags = ["tag1", "tag2"]
      @spec = Spectro::Spec.new('md5', @signature, @description, [@rule], @tags)
    end

    def test_equal
      spec2 = Spectro::Spec.new('md5', @signature, @description, [@rule], @tags)
      assert @spec === spec2
    end

    def test_to_hash
      assert_equal @spec.to_hash, {
        md5: "md5",
        description: "Random Description In Here",
        rules:[
          {
            output: 3,
            params: [1, 2]
          }
        ],
        signature: {
          name: "local_name",
          output_type: "Fixnum",
          params_type: ["Fixnum"]
        },
        tags: [
          "tag1",
          "tag2"
        ]
      }
    end

  end

end
