Factory.define :question, :class => Oracle::Question do |f|
  f.title "What is the meaning of life?"
  f.body "It's what all philosophers have been about."
end

Factory.define :answer, :class => Oracle::Answer do |f|
  f.body "42"
  f.association :question
  # f.association :user
end

# for the user to be valid it would have to have different attributes
# depending on what other plugins tog_oracle is used with.
# So I declared a create_user_without_validation method in test_helper
# and pass user instances to the factories where needed

# Factory.define :user do |f|
# end
