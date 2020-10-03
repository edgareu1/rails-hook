class UsersController < ApplicationController
  def show
    @user_locations = current_user.locations
    @top_fish = current_user.top_fish(3)
    @feed = [
      'The batfish plays dead when danger is near. It floats motionless on its side when scared, making it look like a dead leaf floating on the surface of the water.',
      'Since a fish’s jaw is not attached to its skull, many fishes can shoot their mouths forward like a spring to catch startled prey.',
      'Some fish, such as the herbivorous fish (grazers), often lack jaw teeth but have tooth-like grinding mills in their throats called pharyngeal teeth.',
      'A fish does not add new scales as it grows, but the scales it has increase in size. In this way, growth rings are formed and the rings reveal the age of a fish.',
      'On average, flying fish can glide 160 feet (50m), but have been known to glide as far as 660 feet (200 m). And they can reach heights up to 19 feet (6m).',
      'A fish can drown in water. Like humans, fish need oxygen, so if there isn’t enough oxygen in the water, they will suffocate.',
      'The fish in the middle of a school control the school. The fish on the outside are guided by those in the middle. Only bony fish can swim in highly coordinated groups.',
      'The most poisonous fish in the world is the stone fish. Its sting can cause shock, paralysis, and even death if not treated within a few hours.',
      'A male emperor angelfish lives with up to five female mates. If the emperor angelfish dies, one of the females turns into a male fish and becomes the leader of the group.',
      'There are approximately 32,000 different kinds of fish in the world today which is more than all the other kinds of vertebrates combined.',
      'Scientists have explored only 1% of the ocean depths. They believe millions of new kinds of animals and fish are down there, waiting to be discovered.',
      'Fish were the first vertebrates with bony skeletons to appear on Earth. Unlike today’s fish, early fish had no scales, fins, or jawbone, but they did have a dorsal fin.',
      'Unlike most fish, the ocean sunfish does not have a tail. A female sunfish can lay 300 million eggs each year. Each egg is smaller than the period at the end of this sentence.'
    ]
  end
end
