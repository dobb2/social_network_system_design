// intermediate table for calculating popular places for the last day
// we will clean the data after we've calculated the popular locations.
Table rates {
    date timestamp [not null]
    post_id string [not null]
    location_latitude string [not null]
    location_longitude string [not null]
    rate [not null]
}