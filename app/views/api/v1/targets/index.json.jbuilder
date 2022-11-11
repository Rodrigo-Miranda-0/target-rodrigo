json.targets @targets.each do |target|
  json.title target.title
  json.radius target.radius
  json.user_id target.user_id
  json.topic_id target.topic_id
  json.location target.location
end
