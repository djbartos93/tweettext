#this file controls the server with simple commands

require 'rubygems'
reuire  'daemons'

Daemons.run( 'tweettext.rb' )
