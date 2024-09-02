// Replication:
// - master-slave (sync)
// - replication factor 2
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