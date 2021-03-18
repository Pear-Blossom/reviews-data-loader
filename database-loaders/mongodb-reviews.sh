# Reviews collection
mongoimport mongodb://localhost --type csv --db review-service --collection reviews --file reviews.csv --headerline
# Reviews_photos collection
mongoimport mongodb://localhost --type csv --db review-service --collection reviews_photos --file reviews_photos.csv --headerline
# characteristics collection
mongoimport mongodb://localhost --type csv --db review-service --collection characteristics --file characteristics.csv --headerline
# characteristic_reviews collection
mongoimport mongodb://localhost --type csv --db review-service --collection characteristic_reviews --file characteristic_reviews.csv --headerline
