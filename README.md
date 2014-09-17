Twitter++
=====
*Twitter, with (1) more character*

##Description
A twitter clone that allows tweets of up to 141 characters.

Submitted as an assessment for Epicodus but I will be adding features beyond those requirements just for the fun of it.

User interface is undergoing some reconstruction to make it more ajaxy / functional.

##Screenshot (9/17/2014)

![twitter++ UI](https://raw.githubusercontent.com/jaspeers/twitter_plusplus/master/public/screenshot.png)

## Install
    clone project, cd to that folder
    bundle install
    rake db:create && rake db:schema:load
    rails s
    load this URL in your browser: localhost:3000

## usage
Create a new account with the sign-in button.
To mention another user, type their handle into your tweet, preceeded by an '@' symbol, much like the real twitter.

    Example: "Hi @barackobama I am mentioning you!"

The navigation bar at the top will allow you to edit your account (add bio/avatar, edit handle etc). There are also search boxes to find users or tweets.

##Author
Justin Speers <speersjustin@fastmail.fm>

##License
GPL
See LICENSE.txt for more information.
