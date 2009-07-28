TogOracle
=========

tog_oracle is the Questions & Answers component of the tog platform. Registered users can ask questions and answer others' questions. The maker of the question can close the question by picking a suitable answer no earlier than 1 hour after the question had been posed.

A question that is still open after the 7th day will be auto-closed by a cron-like task and the question's owner notified about this and asked to pick a suitable answer.


Resources
=========

Install
-------

rake rails:template LOCATION=http://tr.im/tog_oracle_0_5_0


Sending out "please close question" requests for overdue questions regularly
============================================================================
This is done with the rufus-scheduler gem, see the init.rb file.


More
----

[http://github.com/tog/tog\_oracle]:(http://github.com/tog/tog_oracle)

[http://github.com/tog/tog\_oracle/wikis](http://github.com/tog/tog_oracle/wikis)



Copyright (c) 2009 Keras Software Development, released under the MIT license
