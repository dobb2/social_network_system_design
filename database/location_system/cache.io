
// store the last 20 posts from this location in reverse chronological order
Table location_posts {
  location_latitude_longitude string [primary key, note: 'key coordinates for cache']
  location_posts post[20]
}

Table popular_location {
    location_latitude_longitude string
    avg_rate int [note: 'average score of posts with the specified location']
}

// the structure of posts that we store in popular locations in cache
Table post {
  id string [primary key]
  author_id string [not null, note: 'author id of the post']
  created_at timestamp [not null]
  location_name varchar(50) [not null]
  location_latitude float8 [not null]
  location_longitude float8 [not null]
  description varchar(1000) [note: 'Content of the post']
  media "varchar(255)[3]" [note: 'image urls']
}