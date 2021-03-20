# Reviews collection
mongoimport mongodb://localhost --type csv --db review-service --collection reviews --file reviews.csv --headerline
# db.reviews.updateMany({}, { $rename: { 'id': 'review_id'} })
# db.reviews.update({recommend: 'true'}, {$set: {recommend: true}}, {multi: true})
# db.reviews.update({recommend: 'false'}, {$set: {recommend: false}}, {multi: true})
# db.reviews.update({recommend: 1}, {$set: {recommend: true}}, {multi: true})
# db.reviews.update({recommend: 0}, {$set: {recommend: false}}, {multi: true})
# db.reviews.createIndex({ product_id: 1 }, { name: 'query by product_id' })
# db.reviews.createIndex({ review_id: 1 }, { name: 'query by review_id' })
# Reviews_photos collection
mongoimport mongodb://localhost --type csv --db review-service --collection reviews_photos --file reviews_photos.csv --headerline
# db.reviews_photos.createIndex({ review_id: 1 }, { name: 'query by review_id' })
# embed photos url into the respective review document
db.reviews.find({}).forEach(function(review) {
  print(review.product_id);
  var temp = [];
  db.reviews_photos.find({ review_id: review.review_id }).forEach(function(photo) {
    temp.push({ id: photo.id, url: photo.url});
  });
  review.photos = temp;
  db.reviews.save(review);
});

# characteristics collection
mongoimport mongodb://localhost --type csv --db review-service --collection characteristics --file characteristics.csv --headerline
# db.characteristics.createIndex({ product_id: 1 }, { name: 'query by product_id' })
# characteristic_reviews collection
mongoimport mongodb://localhost --type csv --db review-service --collection characteristic_reviews --file characteristic_reviews.csv --headerline
# db.characteristic_reviews.createIndex({ characteristic_id: 1 }, { name: 'query by characteristic_id' })
# db.characteristic_reviews.createIndex({ review_id: 1 }, { name: 'query by review_id' })


# delete a field in a collection
# db.example.update({}, {$unset: {words:1}} , {multi: true});