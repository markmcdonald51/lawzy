# Rails 5 Chess
A simple chess server written in Rails 5 using Action Cable-powered WebSockets. Allows two (or more) people to play a live game of chess against each other.

I did a full blog post on how Action Cable was used here: http://jargon.io/joeyschoblaska/rails-5-chess-with-action-cable-websockets

![](https://raw.githubusercontent.com/joeyschoblaska/rails5chess/master/demo.gif)


--------

I am just a bit curious as to why this is blank:

http://codes.lp.findlaw.com/uscode/12/7
l = Legal.find 7905

=> #<Legal:0x007fb2b0e6a040
 id: 8356,
 title: "Chapter 7 FARM CREDIT ADMINISTRATION",
 body: nil,
 parent_id: 7905,
 source: "http://codes.lp.findlaw.com/uscode/12/7",
 created_at: Mon, 25 Apr 2016 12:39:01 UTC +00:00,
 updated_at: Mon, 25 Apr 2016 12:39:01 UTC +00:00>
[13] pry(main)> l.children

also interesting why this is all ommitted: http://codes.lp.findlaw.com/uscode/8

Circular structure revolving around the 'Central Bank'


this will be the parent :
http://codes.lp.findlaw.com/uscode/12
=> #<Legal:0x007fb2b03dd938
 id: 7905,
 title: "Title 12 BANKS AND BANKING",
 body: nil,
 parent_id: nil,
 source: "http://codes.lp.findlaw.com/uscode/12",
 created_at: Mon, 25 Apr 2016 12:33:47 UTC +00:00,
 updated_at: Mon, 25 Apr 2016 12:33:47 UTC +00:00>
[5] pry(main)> 

# lawzy
