// Replication:
// - master-slave (async)
// - replication factor 2
// With a small rps per record the replication lag will be low,
// so there is no requirement and no need for strong consistency.
// in this case the data will be given to a user from another service that has prepared posts
//
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

