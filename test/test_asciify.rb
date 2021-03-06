require 'test/unit'
require 'asciify'

class TestAsciify < Test::Unit::TestCase
  def test_asciify
    assert_equal "".asciify, ""
    assert_equal "foo\r\nbar\nfoo".asciify, "foo\r\nbar\nfoo"
    assert_equal "Iñtërnâtiônàlizætiøn".asciify("?"), "I?t?rn?ti?n?liz?ti?n"
    assert_equal "Mötorhead".asciify("(missing)"), "M(missing)torhead"
  end

  def test_mapping
    map = Asciify::Mapping.new(:default)
    assert_equal "äöü".asciify(map), "aeoeue"
    assert_equal "„foo”".asciify(map), '"foo"'

    a = Asciify.new(map)
    assert_equal a.convert("© Copyright"), "(c) Copyright"
  end

  def test_mapping_alias
    map = Asciify::Mapping[:default]
    assert_equal "äöü".asciify(map), "aeoeue"
  end

  def test_default_replace_with_hash
    map = Asciify::Mapping.new(:default,"*")
    assert_equal "Iñtërnätiönàlizætiön".asciify(map), "I*t*rnaetioen*lizaetioen"
  end

  def test_htmlentities
    map = Asciify::HTMLEntities.new
    assert_equal "Ø €".asciify(map), "&#216; &#8364;"
    
  end

  def test_ascii?
    assert "foo".ascii?
    assert "ä".ascii? == false
    assert "".ascii?
  end
end
