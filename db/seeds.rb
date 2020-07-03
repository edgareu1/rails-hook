# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Fish.destroy_all
Log.destroy_all
Location.destroy_all
User.destroy_all

Fish.create(common_name: 'Yellow Fin Tuna', scientific_name: 'Thunnus albacares', legal_weight: 2.7, legal_size: 0, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/yftuna_n83xos.png", description: 'Live in shoals near the surface, however, sometimes make short dives to depths exceeding 500 m, looking for food like squid, crustaceans and a variety of fish. The reproductive peak occurs in the summer.')

Fish.create(common_name: 'Bluemouth', scientific_name: 'Helicolenus dactylopterus', legal_weight: 0, legal_size: 0, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/bluemouth_sbjocv.png", description: 'It dwells on the seabed between 200-1,000 m, often around underwater wrecks. It is a solitary species and aggregate only at the time of reproduction, which occurs in summer. It feeds on fish, crustaceans and some cephalopods.')

Fish.create(common_name: 'Horse Mackerel', scientific_name: 'Trachurus trachurus', legal_weight: 0, legal_size: 15, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/horsemackerel_rnfugs.png", description: 'It inhabits the water column in the coastal areas, from the surface to the bottom, between 0 to 200 m of depth. Horse mackerels form large schools that migrate for long distances, feeding on small crustaceans, fish and molluscs. It spawns from December to April.')

Fish.create(common_name: 'Chub Mackerel', scientific_name: 'Scomber colias', legal_weight: 0, legal_size: 20, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/chubmacker_u7a9fd.png", description: 'Inhabits the water column of the coastal areas down to 250 m depth. Chub Mackerels form large schools that are strongly migratory, remaining close to the bottom during the day and moving upwards at night to hunt for fish, molluscs and small crustaceans. It spawns from February to April, when the female releases 100,000 to 400,000 eggs.')

Fish.create(common_name: 'Wreckfish', scientific_name: 'Polyprion americanus', legal_weight: 0, legal_size: 0, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/wreckfish_znnvks.png", description: 'The juveniles can be found in the surface layers of the water column and the adults at depths between 100 and 200 m. Juveniles form schools and can be found close to floating objects, while adults are solitary and can be seen in caves or wrecks. It feeds on crustaceans, molluscs and fish. They have multiple spawns, from late July to early October.')

Fish.create(common_name: 'Conger Eel', scientific_name: 'Conger conger', legal_weight: 0, legal_size: 58, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/conger_zemzxh.png", description: 'Inhabits the waters near the bottom, but can live in depths exceeding 1,000 m. During the day it shelters in rocky crevices from where it gets out at night to hunt for fish, crustaceans and cephalopods, but it also hunts in the water column. It spawns in the summer months, away from the coast and at greater depths.')

Fish.create(common_name: 'Meagre', scientific_name: 'Argyrosomus regius', legal_weight: 0, legal_size: 42, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/meagre_nyjbot.png", description: 'The Meagre that can attain a large size has an elongated body, oblique scales, silver coloured dark back and a large mouth with several rows of teeth. It inhabits the entire water column in areas between 15 and 200 m of depth. It is migratory and feeds on fish and crustaceans. It spawns from April to July, in estuaries and coastal lagoons.')

Fish.create(common_name: 'Gilt-head Seabream', scientific_name: 'Sparus aurata', legal_weight: 0, legal_size: 19, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/gilthead_maewbb.png", description: 'The Gilt-Head Seabream has a very oval grey silvery body and a golden spot between the eyes that brings this fish the name “gilt”. It inhabits the water column in areas down to 150 m of depth. It lives either solitarily or in small groups and feeds on molluscs, crustaceans and sea urchins. It spawns at sea from October to December but the juveniles seek the protection of the estuaries to develop.')

Fish.create(common_name: 'Swordfish', scientific_name: 'Xiphias gladius', legal_weight: 25, legal_size: 125, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/swordfish_dme4os.png", description: 'The Swordfish has a wide body without scales, a bluish black back and lighter belly with an elongated snout forming a characteristic flattened sword that it uses to divide the schools and to defend itself. It inhabits the water column down to 800 m of depth. It is a solitary fish, highly migratory, very voracious and aggressive, ingesting their prey in one piece. It spawns from January to October.')

Fish.create(common_name: 'Blackspot Seabream', scientific_name: 'Pagellus bogaraveo', legal_weight: 0, legal_size: 25, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/blackspotbream_e5aqk3.png", description: 'The Blackspot Seabream has a reddish oval body, a dark spot near the head and the inside of the mouth is reddish-orange. It is found in the Northeast Atlantic, where it lives near the seabed down to 700 m, but most juveniles live in shoals along the coast. It feeds on crustaceans, molluscs and small fish. It spawns in summer and in the autumn.')

Fish.create(common_name: 'Sole', scientific_name: 'Solea solea', legal_weight: 0, legal_size: 24, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/sole_l1rno0.png", description: 'The Sole, has an oval flattened body, usually white underside and brown upper side where both eyes are located. It blends into the bottom thereby camouflaging itself. Adults live in coastal areas down to 200 m depth while the juveniles prefer the estuaries. It feeds on small worms, molluscs and small crustaceans. It spawns from January to April.')

Fish.create(common_name: 'Red Porgy', scientific_name: 'Pagrus pagrus', legal_weight: 0, legal_size: 20, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/redporgy_nudeli.png", description: 'The Red Porgy has a silvery-pink sturdy oval body, with a distinct lateral line of scales all the way to the tail fin. Juveniles are found in shallow and sheltered areas, migrating to deeper zones throughout their life, down to 300 m. It feeds on other fish, crustaceans and cephalopods. It spawns in spring and early summer. Most red porgies are born female and only change sex into males with sexual maturation.')

Fish.create(common_name: 'John Dory', scientific_name: 'Zeus faber', legal_weight: 0, legal_size: 0, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/johndory_h9wrcp.png", description: 'The John Dory has an oval laterally compressed flat body and a dorsal fin with strong spines and membranes that extend into long filaments. It is greyish-green and gold with a characteristic black spot on both sides of the body. It inhabits waters close to the seabed, from the coast down to 400 m. It feeds on other fish and sometimes on squid and cuttlefish. It spawns in late winter and early spring.')

Fish.create(common_name: 'European Hake', scientific_name: 'Merluccius merluccius', legal_weight: 0, legal_size: 27, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/euhake_nh21ti.png", description: 'The European Hake has an elongated body, a large black mouth with numerous teeth and a prominent jaw; it has a dark grey back and silvery flanks and belly. It inhabits waters close to the bottom, between 30 and 1,000 m. It forms schools that migrate to deeper areas during the winter. It stays at the bottom during the day, coming to the water column at night to feed on fish such as anchovies, sardines and herring. It spawns mainly from January to April.')

Fish.create(common_name: 'European Sea Bass', scientific_name: 'Dicentrarchus labrax', legal_weight: 0, legal_size: 36, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/seabass_xy6lrg.png", description: 'The European Sea Bass has an elongated silver-grey body with blue or green reflections. Inhabits the estuaries as a juvenile, supporting low salinity waters. The adults inhabit waters down to 100 m of depth. Juveniles form schools together with other species while the adults live alone. It feeds on crustaceans, fish and molluscs. It spawns from January to April.')

Fish.create(common_name: 'Red Mullet', scientific_name: 'Mullus surmuletus', legal_weight: 0, legal_size: 18, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/redmullet_mohrm7.png", description: 'The Red Mullet is a small, reddish fish with three longitudinal yellow bands. It dwells on the bottom of the sea down to 100 m. It forms schools and feeds on crustaceans and small molluscs and fish. It spawns in late winter to early summer, the juveniles remaining in the water column, moving down to the bottom when they reach adulthood.')

Fish.create(common_name: 'Sardine', scientific_name: 'Sardina pilchardus', legal_weight: 0, legal_size: 11, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/sardinha_cg6ot1.png", description: 'The Sardine has an elongated body covered with scales, with a darker blue-silvery coloured back and lighter silvery coloured sides and belly. Inhabits the water column in coastal zones between 25-100 m of depth. It migrates in large schools that seek protection from predators during the day in deeper water and at night ascend to surface waters to feed on algae and small crustaceans. It spawns from October to April when it is leaner, and females can release 50,000 to 60,000 eggs.')

Fish.create(common_name: 'White Seabream', scientific_name: 'Diplodus sargus', legal_weight: 0, legal_size: 15, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/whiteseabream_y4tyqo.png", description: 'The White Seabream has a silver coloured oval body with nine vertical black bands and a characteristic black spot near the tail fin. It inhabits estuaries as a juvenile and depths down to 150 m as adult. It feeds mainly at night on molluscs, crustaceans, sea urchins and seaweed it finds on the bottom. Spawning occurs in late winter and early spring, when they form large schools.')

Fish.create(common_name: 'Cuttlefish', scientific_name: 'Sepia officinalis', legal_weight: 0, legal_size: 10, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/cuttlefish_rzpnrg.png", description: 'The Cuttlefish has a flattened oval body with an internal shell, the cuttlebone, eight arms with suction cups and two rows of long, retractable tentacles that it uses to catch prey. The grey and white body often shows dark dorsal bands. It dwells close to the seabed, being more common down to 200 m. It is a nocturnal predator that feeds preferentially on crabs, mussels and fish. In the summer it migrates to more coastal waters; spawning occurs between February and October, the female laying up to 4,000 eggs.')

Fish.create(common_name: 'Squid', scientific_name: 'Loligo vulgaris', legal_weight: 0, legal_size: 10, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591264/HOOK/squid_h7rp67.png", description: 'The Squid has an elongated, cylindrical body with an internal shell, the gladius, triangular fins taking up two thirds of the body, eight arms with rows of suction cups and two non-retractable feeding tentacles that it uses to catch prey. It has a reddish-pink colour with brownish spots on the dorsal area. Inhabits depths between 20 and 250 m. It feeds mainly on fish and crustaceans. It spawns from October to February and April to June, at which moments it can be mainly found in coastal waters.')

Fish.create(common_name: 'Common Octopus', scientific_name: 'Octopus vulgaris', legal_weight: 0.75, legal_size: 0, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591265/HOOK/octopus_ydgfhp.png", description: 'The Common Octopus has a soft bag-like body, eight arms with two rows of suction cups each and a colour and texture that varies according to the state of the animal and the surroundings, due to its camouflage ability. It inhabits the coastal waters down to 200 m of depth. It feeds on crustaceans (especially crabs), molluscs and fish. It spawns throughout the year, with periods of greater intensity in spring and autumn and the female dies after laying and caring for about 500,000 eggs. The males die after the mating period.')

Fish.create(common_name: 'Spotted Seabass', scientific_name: 'Dicentrarchus punctatus', legal_weight: 0, legal_size: 20, picture_url: "https://res.cloudinary.com/tomfishson/image/upload/v1593591276/HOOK/baila_ovlsty.png", description: 'The Spotted Seabass has an elongated silver-grey body with small black spots. It inhabits coastal waters ranging in  depth from 0  - 30  meters.')

puts "Fish created"


laure = User.new(email: "laure@gmail.com", password: "123456")
laure.save

puts "User created"

cascais = Location.create(latitude: 38.72240025, longitude: -9.396909171649877, name: "cascais", user: laure)
puts "location created"

Log.create(start_time: Time.now, end_time: Time.now, rating: 2, observation: "goos sesh", location: cascais, user: laure)
puts "created log"

Catch.create(weight: 3.5, fish_id: 91, quantity: 3)
puts "created catch"