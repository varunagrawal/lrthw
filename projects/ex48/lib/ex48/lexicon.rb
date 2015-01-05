module Lexicon
 
  def Lexicon.scan(object)
    
    words = object.downcase.split
    
    result = []
    
    words.each do |word|
      
      x = convert_from_lexicon(word)
      if x != nil
        result.push x
      else
        x = convert_number(word)
        if x != nil
          result.push ['number', x]
        else
          result.push ['error', word]
        end
      end
      
    end
    
    return result
    
  end
  
  def Lexicon.convert_from_lexicon(word)
    lexicon = {
      'direction' => ['north', 'south', 'east', 'west', 'down', 'up', 'left', 'right', 'back'],
      'verb' => ['go', 'stop', 'kill', 'eat'],
      'stop' => ['the', 'in', 'of', 'from', 'at', 'it'],
      'noun' => ['door', 'bear', 'princess', 'cabinet']
    }
    
    lexicon.keys.each do |key|
      if lexicon[key].include? word
        return [key, word]
      end
    end
      
    return nil
    
  end
  
  def Lexicon.convert_number(object)
    begin
      return Integer(object)
    rescue
      return nil
    end
  end
  
end