-- characteristics has duplicate ids
CREATE TABLE characteristics (
  id            serial primary key,
  product_id    bigint,
  name          varchar(20)
);

-- COPY characteristics FROM '/Users/wilsoncheah/Documents/hackreactor/sei/reviews-data-loader/data/characteristics.csv' DELIMITER ',' CSV HEADER ;
COPY characteristics FROM '/home/ubuntu/characteristics.csv' DELIMITER ',' CSV HEADER ;
SELECT max(id) FROM characteristics;
ALTER SEQUENCE characteristics_id_seq RESTART WITH 3347478;

-- I'm going to need to retain the original ID for characteristics

-- SELECT COUNT(*)
-- FROM temp_characteristics
-- WHERE temp_id IN (
--   SELECT temp_id
--   FROM temp_characteristics
--   GROUP BY temp_id
--   HAVING COUNT(*) > 1
-- )
-- GROUP BY temp_id;

CREATE TABLE characteristic_reviews (
  id                  serial primary key,
  characteristic_id   bigint NOT NULL,
  review_id           bigint NOT NULL,
  value               smallint NOT NULL,
  FOREIGN KEY(characteristic_id)
    REFERENCES characteristics(id)
    ON DELETE CASCADE
);

-- ERROR:  there is no unique constraint matching given keys for referenced table "characteristics"
-- I thought that I had duplicate IDs but I just didn't define id in characteristics as a primary key

-- COPY characteristic_reviews FROM '/Users/wilsoncheah/Documents/hackreactor/sei/reviews-data-loader/data/characteristic_reviews.csv' DELIMITER ',' CSV HEADER ;
COPY characteristic_reviews FROM '/home/ubuntu/characteristic_reviews.csv' DELIMITER ',' CSV HEADER ;
SELECT max(id) FROM characteristic_reviews;
ALTER SEQUENCE characteristic_reviews_id_seq RESTART WITH 19337415;

CREATE TABLE reviews_temp (
  id                bigint,
  product_id        bigint,
  rating            smallint,
  date              varchar(20),
  summary           varchar(1000),
  body              varchar(1000),
  recommend         varchar(10),
  reported          varchar(10),
  reviewer_name     varchar(60),
  reviewer_email    varchar(60),
  response          varchar(1000),
  helpfulness       smallint
);

-- COPY reviews_temp FROM '/Users/wilsoncheah/Documents/hackreactor/sei/reviews-data-loader/data/reviews.csv' DELIMITER ',' CSV HEADER ;
COPY reviews_temp FROM '/home/ubuntu/reviews.csv' DELIMITER ',' CSV HEADER ;
-- DO TRANSFORMATIONS FROM reviews_temp -> reviews

CREATE TABLE reviews AS
SELECT
  id, product_id, rating,
  TO_DATE(date, 'YYYY-MM-DD') AS date,
  summary, body,
  CAST(recommend AS boolean),
  CAST(reported AS boolean),
  reviewer_name, reviewer_email,
  response, helpfulness
FROM reviews_temp;

-- GOAL for reviews
-- CREATE TABLE reviews (
--   id                serial primary key,
--   product_id        bigint NOT NULL,
--   rating            smallint NOT NULL,
--   date              date NOT NULL,
--   summary           varchar(1000),
--   body              varchar(1000) NOT NULL,
--   recommend         boolean NOT NULL,
--   reported          boolean,
--   reviewer_name     varchar(60) NOT NULL,
--   reviewer_email    varchar(60) NOT NULL,
--   response          varchar(1000),
--   helpfulness       smallint
-- );

-- created the sequencing for reviews id
-- setting next value in sequence to default reviews id
CREATE SEQUENCE reviews_id_seq;
ALTER TABLE reviews ALTER COLUMN id SET DEFAULT nextval('reviews_id_seq');
ALTER SEQUENCE reviews_id_seq OWNED BY reviews.id;
SELECT max(id) FROM reviews;
ALTER SEQUENCE reviews_id_seq RESTART WITH 5777922;

-- set up constraints for the reviews table
-- set id to primary key
ALTER TABLE reviews
ADD PRIMARY KEY (id);
-- set not null for
  -- product_id
  -- rating
  -- date
  -- body
  -- recommend
  -- reviewer_name
  -- reviewer_email
ALTER TABLE reviews
ALTER COLUMN product_id SET NOT NULL,
ALTER COLUMN rating SET NOT NULL,
ALTER COLUMN date SET NOT NULL,
ALTER COLUMN body SET NOT NULL,
ALTER COLUMN recommend SET NOT NULL,
ALTER COLUMN reviewer_name SET NOT NULL,
ALTER COLUMN reviewer_email SET NOT NULL,
ALTER COLUMN summary SET DEFAULT NULL,
ALTER COLUMN reported SET DEFAULT FALSE,
ALTER COLUMN response SET DEFAULT NULL,
ALTER COLUMN helpfulness SET DEFAULT 0
;

CREATE TABLE reviews_photos (
  id          serial primary key,
  review_id   bigint NOT NULL,
  url         varchar(1000) NOT NULL,
  FOREIGN KEY(review_id)
    REFERENCES reviews(id)
    ON DELETE CASCADE
);

-- COPY reviews_photos FROM '/Users/wilsoncheah/Documents/hackreactor/sei/reviews-data-loader/data/reviews_photos.csv' DELIMITER ',' CSV HEADER ;
COPY reviews_photos FROM '/home/ubuntu/reviews_photos.csv' DELIMITER ',' CSV HEADER ;
SELECT max(id) FROM reviews_photos;
ALTER SEQUENCE reviews_photos_id_seq RESTART WITH 2742832;


-- indexing
CREATE INDEX ON reviews (product_id);
CREATE INDEX ON reviews_photos (review_id);
CREATE INDEX ON characteristics (product_id);
CREATE INDEX ON characteristic_reviews (characteristic_id);
-- CREATE INDEX ON characteristic_reviews (review_id);
-- CREATE INDEX ON characteristics (id);


-- used to see logged in users
select distinct username from pg_stat_activity;
