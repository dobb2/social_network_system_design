// Replication:
// - master-slave (async)
// - replication factor 2
// With a small rps per record the replication lag will be low,
// so there is no requirement and no need for strong consistency.
// in this case the data will be given to a user from another service that has prepared comments in post
//
// Sharding:
// - key based by post_id

Table comments {
  id string [primary key]
  post_id string [not null, note: '']
  author_id string [not null, note: 'author id of the comment']
  comment varchar(500) [not null]
  created_at timestamp [not null]
}