
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Song.create(title:'Someone like you', image:'https://www.tradebit.com/usr/aldy32/pub/9002/SomeoneLikeYou_PianoAccompaniment_-Adele.gif', image:'http://mail.google.com/', category:'Balada')
instruments = Instrument.create([{name: "flute"}, {name: "guitar"}, {name: "violin"}, {name: "piano"}, {name: "saxo"}])
flutesongs = Instrument.find(1).songs.create([{title: "Flute song demo 1", category: "A category"}, {title: "Flute song demo 2", category: "Another category"}])
guitarsongs = Instrument.find(2).songs.create([{title: "Guitar song demo 1", category: "A category"}, {title: "Guitar song demo 2", category: "Another category"}])
violinsongs = Instrument.find(3).songs.create([{title: "Violin song demo 1", category: "A category"}, {title: "Violin song demo 2", category: "Another category"}])
pianosongs = Instrument.find(4).songs.create([{title: "Piano song demo 1", category: "A category"}, {title: "Piano song demo 2", category: "Another category"}])
saxosongs = Instrument.find(5).songs.create([{title: "Saxophone song demo 1", category: "A category"}, {title: "Saxophone song demo 2", category: "Another category"}])