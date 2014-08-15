
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Song.create(title:'Someone like you', image:'https://www.tradebit.com/usr/aldy32/pub/9002/SomeoneLikeYou_PianoAccompaniment_-Adele.gif', image:'http://mail.google.com/')
instruments = Instrument.create([{name: "flute"}, {name: "guitar"}, {name: "violin"}, {name: "piano"}, {name: "saxo"}])
flutesongs = Instrument.find(1).songs.create([{title: "Flute song demo 1"}, {title: "Flute song demo 2"}])
guitarsongs = Instrument.find(2).songs.create([{title: "Guitar song demo 1"}, {title: "Guitar song demo 2"}])
violinsongs = Instrument.find(3).songs.create([{title: "Violin song demo 1"}, {title: "Violin song demo 2"}])
pianosongs = Instrument.find(4).songs.create([{title: "Piano song demo 1"}, {title: "Piano song demo 2"}])
saxosongs = Instrument.find(5).songs.create([{title: "Saxophone song demo 1"}, {title: "Saxophone song demo 2"}])
classical =Category.create(name:'Classical')
jazz = Category.create(name:'Jazz')
rock = Category.create(name:'Rock')
pop = Category.create(name:'Pop')
rap = Category.create(name:'Rap')
blues = Category.create(name:'Blues')
dubstep = Category.create(name:'Dubstep')

tags = Tag.create([{name:"Cool"},{name:"Melody"},{name:"Instrumental"},{name:"Sad"},{name:"Hard"},{name:"Medium"},{name:"Begginer"}])

Category.create(name:'Classical')
Category.create(name:'Jazz')
Category.create(name:'Rock')
Category.create(name:'Pop')
Category.create(name:'Rap')
Category.create(name:'Blues')
Category.create(name:'Dubstep')


admin3 = User.create(email: 'p.murcia.morilla@gmail.com', password: 'adminadmin', password_confirmation: 'adminadmin')
admin3.add_role :admin

admin2 = User.create(email: 'henar_d0el_96@hotmail.es', password: 'adminadmin', password_confirmation: 'adminadmin')
admin2.add_role :admin

admin1 = User.create(email: 'asuperalvaro@hotmail.com', password: 'adminadmin', password_confirmation: 'adminadmin')
admin1.add_role :admin

smashbros = Instrument.find(1).songs.create(title: "Smash Bros Brawl")
midis_smashbros = smashbros.midis.create(url:"SSBB Main Theme.mp3")
youtube_videos = smashbros.videos.create(url:'<iframe width="640" height="390" src="//www.youtube.com/embed/gnAyTNUOkvc" frameborder="0" allowfullscreen></iframe>')