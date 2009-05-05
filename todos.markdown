* include the tog_oracle stylesheet on tog_oracle pages
* check delayed_job for setting up a runner every day
* try to put the rendering of the page/action in oracle/questions/:id/answers into helpers
* when no answers/questions exist, put an explanation there, not just a blank list
* display the author and the date the question was posed on question lists and the "answers to a question" page


DONE
====
* make a pick suitable answer + edit links on the member_oracle_questions page (Your questions)
* possibility of reporting abuse for questions
* possibility of tagging questions
* test delivery of overdue notification messages
* question and answers should not be modified once the question is closed
* check that only the question's publisher can pick the suitable answer, edit the question, etc.
* add title to questions
* let the question be editable (edit page for question)
* AnswersController.update - can we use fields_for on the index form? X
* add some common sense links to pages
* i18n the close_question_request mail
* i18n
* check that the question can not be closed(= a suitable answer picked) if it is <1 hour after posting the question.
* set up a runner that checks for questions that should be closed
* remove radio buttons to select suitable answer once the question is closed
* mark suitable answer in the list of answers for a particular question  

