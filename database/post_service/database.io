// Replication:
// - master-slave (sync)
// - replication factor 2
// sync, because have 35 rps to write
// Sharding:
// - key based by id and author_id


Table posts {
  id string [primary key]
  author_id string [not null, note: 'author id of the post']
  created_at timestamp [not null]
  location_name varchar(50) [not null]
  location_latitude float8 [not null]
  location_longitude float8 [not null]
  description varchar(1000) [note: 'Content of the post']
  media "varchar(255)[3]" [note: 'image urls']
}

