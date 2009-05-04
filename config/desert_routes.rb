namespace :member do |member|
  member.namespace :oracle do |oracle|
    oracle.resources :questions do |question| # , :shallow => true
      question.resources :answers
    end
  end
end

namespace :oracle do |oracle|
  oracle.resources :questions, :collection => { :closed => :get } do |question| #, :shallow => true
    question.resources :answers
  end
end
