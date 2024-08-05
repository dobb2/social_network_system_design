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


### Non-functional requirements:

*  linear growth during the year to 10 000 000 DAU
*  on average, 15 percent of users publish 2 posts per day
*  on average, 30 percent of users rate 5 posts per day
*  on average, 5 percent of users comment 3 posts per day
*  users view an average of 15 posts per day
*  availability 99,99%
*  CIS region of use
*  always keep the data (posts, comments, rates)
*  maximum number of subscriptions 1000, maximum number of subscriptions per day 50 
*  maximum number of ratings per day 100
*  maximum number of comments per day 30
*  average number of comments per post 10
*  mobile and web versions
*  the list of popular places may not be updated immediately
*  comments post should reach in 5 seconds
*  post evaluations should come as soon as possible
*  in summer and on big calendar weekends, a 50 percent increase in user activity 
*  subscription feed in chronological order
*  the subscription feed should be updated as quickly as possible
*  popular places by location are updated once a day (based on estimates)
*  2000 characters limit for post
*  5 image limit for post
*  maximum image size 5 Mb


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
    location_id - 8 byte
    timestamp - 8 bytes
    description - 2000 * 2 ~= 4000 bytes
    media - 5 * 5 ~= 25 Mb
    total_rate - 1 byte
    Total ~= 26 Mb

Traffic:

    (write) 26 Mb * 35 = 910 Mb/s
    (read) 26 Mb * 1740 = 45 Gb/s

Required memory:

    Created posts for 1 year = 10 000 000 * 15% * 2 * 365 = 3 000 000 * 365 post/year
    Each post size ~= 26Mb
    Required memory for 1 year = 3 000 000 * 26 Mb * 365 ~= 78 * 365 Tb ~= 27.8 Pb

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
