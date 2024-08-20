// when adding new ratings recalculate, when giving out posts, give their average rating from the cache
Table average_rates {
  post_id string [not null, note: 'post id']
  avg_rate int [note: 'average rate of post']
  count int [note: 'count rate of post']
}

// for 10,000,000 users from the DAU store a feed of 20 posts
Table feed_posts {
    user_id string [primary key]
    posts post[20]
}

// store up to 20 last posts of each user from DAU
Table user_posts {
    user_id string [primary key]
    posts post[20]
}

// the structure of posts that we store in feed posts in cache
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

// the structure of comments that we store in posts for feed
Table comment {
  id string [primary key]
  post_id string [not null, note: '']
  author_id string [not null, note: 'author id of the comment']
  comment varchar(500) [not null]
  created_at timestamp [not null]
}
