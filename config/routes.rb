namespace :member do |member|
  member.resources :questions, :shallow => true do |question|
    question.resources :answers
  end
end