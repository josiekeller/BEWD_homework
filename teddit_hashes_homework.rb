require 'rest-client'
require 'json'

def get_from_api (url)
JSON.load RestClient.get url
end

def get_from_mashable
  mRes = get_from_api 'http://mashable.com/stories.json'

  mRes["hot"].map do |story|
    mash_story = {title: story["title"], category: story["channel"] }
    calculate_upvotes mash_story
    show_new_story_notification mash_story
    mash_story
  end
end

def get_from_digg
  dRes = get_from_api 'http://digg.com/api/news/popular.json'

  dRes["data"]["feed"].map do |story|
    digg_title = story["content"]["title"]
    digg_cat = story["content"]["tags"].map { |tag| tag["display"]}.join(', ')

    digg_story = { title: digg_title, category: digg_cat }
    calculate_upvotes digg_story
    show_new_story_notification digg_story
    digg_story
  end
end

def get_from_reddit
  rRes = get_from_api 'http://www.reddit.com/.json'

  rRes ["data"]["children"].map do |story|
    reddit_title = story["data"]["title"]
    reddit_cat = story["data"]["subreddit"]

    reddit_story = { title: reddit_title, category: reddit_cat }
    calculate_upvotes reddit_story
    show_new_story_notification reddit_story
    reddit_story
  end
end

def show_message(message)
  puts message
end

def get_input
  gets.strip
end

def show_new_story_notification(story)
  show_message("New story added! #{story[:title]}, Category: #{story[:category].capitalize}, Current Upvotes: #{story[:upvotes]}")
end

def calculate_upvotes(story)
  story[:upvotes] = 1

  if story[:title].downcase.include? 'cat'
    story[:upvotes] *= 5
  elsif story[:title].downcase.include? 'bacon'
    story[:upvotes] *= 8
  end

  if story[:category].downcase == "food"
    story[:upvotes] *= 3
  end
end

def show_all_stories(stories)
  stories.each do |story|
    show_message "Story: #{story[:title]}, Category: #{story[:category].capitalize}, Current Upvotes: #{story[:upvotes]}"
  end
end



show_message("Welcome to Teddit! a text based news aggregator. Get today's news tomorrow!")

stories = get_from_digg + get_from_mashable + get_from_reddit

show_all_stories stories

