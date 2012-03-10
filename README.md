# Common Ruby Object Composition

This approach identifies two responsibilities n the implementation: being a word list and then knowing how to sanitize words. It separates these two responsibilities into two corresponding objects: WordList and WordListSanitizer. 

It's common to what I've seen on a lot of Ruby projects because it constructs the WordListSanitizer inside the WordList constructor. This influences the approach to testing as well as trade-offs with other approaches.

But first, the pros.

## Pros

The big win here is distinctly identifying separate responsibilities and separating those into separate objects. This keeps both objects very focused on what they're doing which makes each one easier to maintain and evolve over time.

## Trade-offs

The literal rules here are quite simple, but in practice more complex rules are often encountered. Using a single rules object like WordListSanitizer to house the implementation of complex rules would quickly become difficult to evolve and maintain both in implementation and in corresponding tests. When there are more complex rules at play we may be better served to separate each distinct rule so they can be maintained on their own.

## Testing

In the default, spec/word_list_spec.rb, all examples still pass, but this approach to testing has some things to consider:

* the word_list_spec is at risk to break when the WordListSanitizer changes
* the word_list_spec is dependent on the WordListSanitizer
* if the WordListSanitizer changes we have to update the word_list_spec

By separating the responsibilities into two objects (WordList, WordListSanitizer) our coe is communicating that we don't want the implementation of either object to leak over into the other. This same separation can be performed in our specs.

There is an alternate set of specs to reflect this in spec/impl/. 

### spec/impl/word_list_sanitizer_spec.rb

By creating a separate spec for the sanitizer all examples for the rules can be moved into here. This lets the WordListSanitizer evolve separately from WordList and vise versa. Now that there is a spec for the WordListSanitizer we can update the word_list_spec to no longer need to execute the rules; rather, we can make sure it simply uses the sanitizer in the way we expect.

### spec/impl/word_list_spec.rb

The updated word_list_spec.rb no longer executes the sanitization rules. Instead, it uses mocks and stubs to ensure that the WordListSanitizer is used and that the results of the #sanitize are used to set the words. 

This limits the impact of any changes to WordListSanitizer to the word_list_sanitizer_spec and any changes to WordList to the word_list_spec. This is good because any change that breaks our specs will point us to the right place right away. We won't have to sift through multiple failing examples for multiple objects in order to see where the issue is.

## Reflecting on the approach

* Because this in Ruby, we can get away with instantiating WordListSanitizer in the WordList constructor. In other languages, this wouldn't work because we wouldn't be able to mock/stub this out in our tests.

* This approach limits the code's ability to introduce other types of lists that may share in some, but not all of the rules, that may create new rules. There may be better ways to structure the solution so that it is more flexible to change in respect to the [Open/Closed Principle][0]. 


[0]: http://en.wikipedia.org/wiki/Open/closed_principle