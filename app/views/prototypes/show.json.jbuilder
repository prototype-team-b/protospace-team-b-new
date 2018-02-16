json.array! @comments do |comment|
  json.content    comment.content
  json.id         comment.id
  json.user_name  comment.user.name
end