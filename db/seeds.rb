# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tag.create([
  {
    name: "yoga",
    category: "activity" 
  },
  {
    name: "running",
    category: "activity" 
  },
  {
    name: "tennis",
    category: "activity" 
  },
  {
    name: "rock climbing",
    category: "activity" 
  },
  {
    name: "hiking",
    category: "activity" 
  },
  {
    name: "biking",
    category: "activity" 
  },
  {
    name: "swimming",
    category: "activity" 
  },
  {
    name: "music",
    category: "interest" 
  },
  {
    name: "movies",
    category: "interest" 
  },
  {
    name: "sports",
    category: "interest" 
  },
  {
    name: "healthy eating",
    category: "interest" 
  },
  {
    name: "dogs",
    category: "interest" 
  },
  {
    name: "cats",
    category: "interest" 
  },
  {
    name: "weight loss",
    category: "goal"
  },
  {
    name: "training for marathon",
    category: "goal"
  },
  {
    name: "training for triathlon",
    category: "goal"
  },
  {
    name: "find healthy friends",
    category: "goal"
  }
])

  
