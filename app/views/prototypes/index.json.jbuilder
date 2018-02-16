json.array! @all_prototypes do |prototype|
  json.id               prototype.id
  json.main_image_id    prototype.captured_images[0].id
  # json.main_image       prototype.captured_images[0].content
  json.title            prototype.title
  json.user_id          prototype.user.id
  json.user_name        prototype.user.name
  json.date             prototype.posted_date
end