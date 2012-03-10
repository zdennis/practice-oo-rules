DI.configure do 
  construct :WordList do {
    :sanitizers => [
      ConvertToArraySanitizer.new,
      StripUnallowedCharactersSanitizer.new,
      RemoveUnnecessaryWhitespaceSanitizer.new,
      ReverseWordsThatStartWithVowel.new ]}
  end
end