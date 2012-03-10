DI.configure do 
  construct :ConvertToArraySanitizer do 
    { :thing => "Some injected value" }
  end
  
  construct :WordList do {
    :sanitizers => [
      ConvertToArraySanitizer.new,
      StripUnallowedCharactersSanitizer.new,
      RemoveUnnecessaryWhitespaceSanitizer.new,
      ReverseWordsThatStartWithVowel.new ]}
  end
end