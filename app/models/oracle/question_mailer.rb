class Oracle::QuestionMailer < ActionMailer::Base

  def close_question_request(question)
    publisher = question.user
    @recipients  = "#{publisher.email}"
    @from        = Tog::Config["plugins.tog_core.mail.system_from_address"]
    @subject     = 'Please pick a suitable answer'

    @body[:asker_name] = publisher.profile.name
    # strip tags and html entities from question body
    @body[:question] = question.body.gsub(/\<[^>]*\>/, '').gsub(/&.*?;/, '')
    @body[:answer_link] = oracle_question_answers_url(question)
    @body[:sender_name] = Tog::Config["plugins.tog_core.mail.system_from_address"]
  end

end
