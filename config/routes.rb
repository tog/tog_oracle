namespace :member do |member|
  member.namespace :oracle do |oracle|
    oracle.resources :questions, :shallow => true do |question|
      question.resources :answers
    end
  end
end

namespace :oracle do |oracle|
  oracle.resources :questions, :shallow => true do |question|
    question.resources :answers
  end
end
