// when adding new ratings recalculate, when giving out posts, give their average rating from the cache
Table average_rates {
  post_id string [not null, note: 'post id']
  avg_rate int [note: 'average rate of post']
  count int [note: 'count rate of post']
}
