require "./lib/ex48/parser"
require "minitest/autorun"

class TestGame < Minitest::Test

  def test_peek()
    word_list = [['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey']]
    
    assert_equal(peek(nil), nil)
    assert_equal(peek(word_list), 'noun')
  end
  
  def test_match()
    word_list = [['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey']]
    
    assert_equal(match(nil, 'noun'), nil)
    assert_equal(match(word_list, 'noun'), ['noun', 'bear'])
    assert_equal(match(word_list, 'noun'), nil) # the word_list gets modified due to the shift
  end
  
  def test_skip()
    word_list = [['stop', 'from'], ['stop', 'the'], ['noun', 'west']]
    
    assert_equal(skip_words(word_list, 'stop'), nil)
    assert_equal(skip_words([['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey']], 'noun'), nil)
  end
  
  def test_subject()    
    assert_equal(parse_subject([['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey']]), ['noun', 'bear'])
    assert_equal(parse_subject([['verb', 'eat'], ['noun', 'honey']]), ['noun', 'player'])
  end
  
  def test_verb()
    
    assert_raises ParserError do 
      parse_verb([['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey']]) 
    end
    
    assert_equal(parse_verb([['verb', 'eat'], ['noun', 'honey']]), ['verb', 'eat'])
  end
  
  def test_object()
    assert_equal(parse_object([['stop', 'the'], ['noun', 'bear']]), ['noun', 'bear'])
    assert_equal(parse_object([['stop', 'the'], ['direction', 'south']]), ['direction', 'south'])
    
    assert_raises ParserError do
      parse_object([['verb', 'go']])
    end
  end 
  
  def test_sentence()
    word_list = [['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey']]
    
    sentence = parse_sentence(word_list)
    sent = Sentence.new(['noun', 'bear'], ['verb', 'eat'], ['noun', 'honey'])
    
    assert_equal(sent.subject, sentence.subject)
    assert_equal(sent.verb, sentence.verb)
    assert_equal(sent.object, sentence.object)
  end
  
end
