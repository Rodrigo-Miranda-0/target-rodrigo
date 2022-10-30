json.topics @topics.each do |topic|
  json.name topic.name
  json.image topic.image.url
end
