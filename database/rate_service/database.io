Table rates {
  id string [primary key]
  post_id string [not null, note: 'post id rated']
  author_id string [not null, note: 'author id of the rate']
  rate int [not null, note: 'rate from 0 to 10']
  created_at timestamp [not null]
}