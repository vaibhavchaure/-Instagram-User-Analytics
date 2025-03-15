USE ig_clone;

#  Marketing Analysis:
# Loyal User Reward: Identify the five oldest users on Instagram from the provided database.
SELECT id, username, created_at
FROM users
ORDER BY created_at
LIMIT 5;

# Inactive User Engagement:  Identify users who have never posted single photo on Instagram.
SELECT id, username
FROM users
WHERE NOT EXISTS (SELECT 1 FROM photos WHERE photos.user_id = users.id);

# Contest Winner Declaration: Determine the winner of the contest and provide their details to the team.
SELECT p.id AS photo_id, p.image_url, p.user_id, u.username, COUNT(l.user_id) AS like_count
FROM photos p
JOIN likes l ON p.id = l.photo_id
JOIN users u ON p.user_id = u.id
GROUP BY p.id, u.username
ORDER BY like_count
LIMIT 1;

# Hashtag Research: Identify, suggest the top five most commonly used hashtags on the platform.
SELECT t.tag_name, COUNT(pt.photo_id) AS usage_count
FROM tags t
JOIN photo_tags pt ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY usage_count DESC
LIMIT 5;

# Ad Campaign Launch:  Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign
SELECT DAYNAME(created_at) AS day_of_week, COUNT(*) AS user_count
FROM users
GROUP BY day_of_week
ORDER BY user_count DESC
LIMIT 1;



# Investor Metrics:
# User Engagement: Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.
SELECT 
    (SELECT 
            COUNT(*)
        FROM
            photos) / (SELECT COUNT(*)
        FROM
            users) AS avg_posts_per_user;
            
# Bots & Fake Accounts:  Identify users (bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
SELECT u.id, u.username
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM photos p
    WHERE NOT EXISTS (
        SELECT 1
        FROM likes l
        WHERE l.user_id = u.id AND l.photo_id = p.id
    ));



