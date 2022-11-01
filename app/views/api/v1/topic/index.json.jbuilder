json.topics @topics.each do |topic|
  json.name topic.name
  json.image url_for(topic.image) if topic.image.attached?
end
