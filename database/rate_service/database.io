// Replication:
// - master-slave (async) and Warm Standby
// - replication factor 2
// With a small rps per record the replication lag will be low,
// so there is no requirement and no need for strong consistency.
// in this case the data will be given to a user from another service that has prepared rates
// Sharding:
// - No need for 1 year estimation loads, but virtual sharding split by post_id


Table rates {
  id string [primary key]
  post_id string [not null, note: 'post id rated']
  author_id string [not null, note: 'author id of the rate']
  rate int [not null, note: 'rate from 0 to 10']
  created_at timestamp [not null]
}