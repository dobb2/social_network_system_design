Table average_rates {
  post_id string [not null, note: 'post id']
  avg_rate int [note: 'average rate of post']
  count int [note: 'count rate of post']
}

Table feed_posts {
    user_id string [primary key]
    posts post[20]
}

Table post {
  id string [primary key]
  author_id string [not null, note: 'author id of the post']
  created_at timestamp [not null]
  location_name varchar(50) [not null]
  location_latitude float8 [not null]
  location_longitude float8 [not null]
  description varchar(1000) [note: 'Content of the post']
  media "varchar(255)[3]" [note: 'image urls']
  comments comment[10]
}

Table comment {
  id string [primary key]
  post_id string [not null, note: '']
  author_id string [not null, note: 'author id of the comment']
  comment varchar(500) [not null]
  created_at timestamp [not null]
}
