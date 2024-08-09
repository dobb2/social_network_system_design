# Social network for travelers
Homework for [course by System Design](https://balun.courses/courses/system_design). 
A social network with browsing popular destinations, publishing posts 
and subscribing to other travelers.

### Functional requirements:

* create posts from travels with location
* post commenting
* view comments for post
* post rating
* subscribe to travelers
* view subscription posts
* browsing popular locations
* view posts from a specified location
* view traveler feed
* the user chooses the location for the post from a map


### Non-functional requirements:

*  linear growth during the year to 10 000 000 DAU
*  only 15 percent of users make posts, each averaging 2 posts each
*  only 30 percent of users rate posts, each averaging 5 posts per day
*  only 5 percent of users comment posts, each averaging 3 posts per day
*  all users view an average of 15 posts per day
*  availability 99,99%
*  CIS region of use
*  always keep the data (posts, comments, rates)
*  maximum number of subscriptions 1000, maximum number of subscriptions per day 50 
*  maximum number of ratings per day 100
*  maximum number of comments per day 30
*  average number of comments per post 10
*  mobile and web versions
*  the list of popular places should be updated once a day (based on rates)
*  comments post should reach in 3 seconds
*  post evaluations should be delivered in 3 seconds
*  in summer and on big calendar weekends, a 30 percent increase in user activity
(create posts, comments, rates and reading content) 
*  subscription feed in reverse chronological order
*  the subscription feed should be updated in 5 seconds
*  1000 characters limit for post
*  3 image limit for post
*  maximum image size 1 Mb


## Load estimation

### subsystem Post

RPS (write):

    DAU = 10 000 000
    on average, 15 percent of users publish 2 posts per day
    RPS = 10 000 000 / 86400 * 0.15 * 2 ~= 35
    RPS in season ~= 35 + 35 * 0.5 ~= 55

RPS (read):

    DAU = 10 000 000
    users view an average of 15 posts per day
    RPS = 10 000 000 / 86400 * 15 ~= 1740
    RPS in season ~= 1740 + 1740 * 0.5 ~= 2610

Size:

    post_id - 8 bytes
    author_id - 8 bytes
    point_location - 16 bytes
    location_name - 50 * 2 ~= 100 bytes
    timestamp - 8 bytes
    description - 1000 * 2 ~= 2000 bytes
    media - 1 * 3 ~= 3 Mb
    total_rate - 1 byte
    Total ~= 3.1 Mb

Traffic:

    (write) 3.1 Mb * 35 ~= 108.5 Mb/s
    (read) 3.1 Mb * 1740 ~= 5,3 Gb/s

Required memory:

    Created posts for 1 year = 10 000 000 * 15% * 2 * 365 = 3 000 000 * 365 post/year
    Each post size ~= 3.1Mb
    Required memory for 1 year = 3 000 000 * 3.1 Mb * 365 ~= 78 * 365 Tb ~= 3.2 Pb

### subsystem Comment

RPS (write):

    DAU = 10 000 000
    on average, 5 percent of users comment 3 posts per day
    RPS = 10 000 000 / 86400 * 0.05 * 3 ~= 18
    RPS in season ~= 18 + 18 * 0.5 ~= 27

RPS (read):

    DAU = 10 000 000
    average number of comments per post 10
    RPS = 10 000 000 / 86400 * 10 ~= 1160
    RPS in season ~= 1160 + 1160 * 0.5 ~= 1740

Size:

    post_id - 8 bytes
    author_id - 8 bytes
    comment - 500 * 2 byte = 1000 bytes
    timestamp - 8 bytes
    Total ~= 1024 bytes

Traffic:

    (write) 1024 bytes * 18 = 3 Kb/s
    (read) 1024 bytes * 1160 ~= 1.1 Mb/s

Required memory:

    Created comments for 1 year = average_number_of_comments_per_post * count_posts_per_year = 
        10 * 3 000 000 * 365 = 30 000 000 * 365
    Each comment size ~= 1024 bytes = 1 Kb 
    Required memory for 1 year = 30 000 000 * 365 * 1 Kb ~= 365 * 28.6 Gb ~= 10.19 Tb

### subsystem Rate

RPS (write):

    DAU = 10 000 000
    on average, 30 percent of users rate 5 posts per day
    RPS = 10 000 000 / 86400 * 0.3 * 5 ~= 175
    RPS in season ~= 175 + 175 * 0.5 ~= 260


Size:

    post_id - 8 bytes
    author_id - 8 bytes
    rate - 1 byte
    Total ~= 17 bytes

Traffic:

    (write) 17 bytes * 175 = 3 Kb/s


Required memory:

    Created rates for 1 year = 10 000 000 * 30% * 5 * 365 = 5 475 000 000
    Each rate size ~= 1024 bytes = 17 bytes 
    Required memory for 1 year = 5 475 000 000 * 17 bytes ~= 86.68 Gb
