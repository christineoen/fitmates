
def dot_product(tag_array1, tag_array2)
  products = tag_array1.zip(tag_array2).map{|a, b| a * b}
  products.inject(0) {|s,p| s + p}
end

def magnitude(tag_array)
  squares = tag_array.map{|x| x ** 2}
  Math.sqrt(squares.inject(0) {|s, c| s + c})
end

def cosine_similarity(tag_array1, tag_array2)
  dot_product(tag_array1, tag_array2) / (magnitude(tag_array1) * magnitude(tag_array2))
end

tag_array1 = [1,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0]
tag_array2 = [1,0,1,0,0,0,0,0,1,0,1,0,1,0,1,0]

cosine_similarity(tag_array1, tag_array2)

2.1.1 :005 > chris.tags
  Tag Load (0.4ms)  SELECT "tags".* FROM "tags" INNER JOIN "taggings" ON "tags"."id" = "taggings"."tag_id" WHERE "taggings"."user_id" = $1  [["user_id", 1]]
+----+------------------------+----------+-------------------------+-------------------------+
| id | name                   | category | created_at              | updated_at              |
+----+------------------------+----------+-------------------------+-------------------------+
| 1  | yoga                   | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 4  | rock climbing          | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 10 | sports                 | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 11 | healthy eating         | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 16 | training for triathlon | goal     | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
+----+------------------------+----------+-------------------------+-------------------------+
5 rows in set
2.1.1 :006 > alli.tags
  Tag Load (0.9ms)  SELECT "tags".* FROM "tags" INNER JOIN "taggings" ON "tags"."id" = "taggings"."tag_id" WHERE "taggings"."user_id" = $1  [["user_id", 3]]
+----+----------------------+----------+-------------------------+-------------------------+
| id | name                 | category | created_at              | updated_at              |
+----+----------------------+----------+-------------------------+-------------------------+
| 1  | yoga                 | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 5  | hiking               | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 6  | biking               | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 8  | music                | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 11 | healthy eating       | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 12 | dogs                 | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 17 | find healthy friends | goal     | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
+----+----------------------+----------+-------------------------+-------------------------+
7 rows in set
2.1.1 :007 > Tag.all
  Tag Load (0.3ms)  SELECT "tags".* FROM "tags"
+----+------------------------+----------+-------------------------+-------------------------+
| id | name                   | category | created_at              | updated_at              |
+----+------------------------+----------+-------------------------+-------------------------+
| 1  | yoga                   | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 2  | running                | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 3  | tennis                 | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 4  | rock climbing          | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 5  | hiking                 | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 6  | biking                 | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 7  | swimming               | activity | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 8  | music                  | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 9  | movies                 | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 10 | sports                 | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 11 | healthy eating         | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 12 | dogs                   | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 13 | cats                   | interest | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 14 | weight loss            | goal     | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 15 | training for marathon  | goal     | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 16 | training for triathlon | goal     | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
| 17 | find healthy friends   | goal     | 2014-09-26 05:59:48 UTC | 2014-09-26 05:59:48 UTC |
+----+------------------------+----------+-------------------------+-------------------------+
17 rows in set

@tags = Tag.all
base_array = []

@tags.each do |tag|
  base_array << tag.id
end

#list all users who are within the radius, and call cosine_similarity on each user to find percentage to display

[2, 6, 8, 13, 17]



[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].map {|number| array.include?(number) ? 1 : 0}

new_array1 = base_array.map {|number| array1.include?(number) ? 1 : 0 }

[2, 5, 11, 12, 15].each do |number|

end

# if the number in the small array exists in the large array, replace it with 1 in the large array, if not, replace it with zero



[2, 5, 11, 12, 15]
[0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0]
[0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1]
[0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0] 
[0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0] 
[0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0] 
[0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0] 






