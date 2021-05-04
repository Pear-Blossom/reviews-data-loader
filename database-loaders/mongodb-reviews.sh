# SEED MONGODB
# reviews
mongoimport mongodb://localhost --type csv --db review-service --collection reviews --file reviews.csv --headerline
# reviews_photos
mongoimport mongodb://localhost --type csv --db review-service --collection reviews_photos --file reviews_photos.csv --headerline
# characteristics
mongoimport mongodb://localhost --type csv --db review-service --collection characteristics --file characteristics.csv --headerline
# characteristic_reviews
mongoimport mongodb://localhost --type csv --db review-service --collection characteristic_reviews --file characteristic_reviews.csv --headerline

# TRANSFORMATIONS
# reviews
db.reviews.updateMany({}, { $rename: { 'id': 'review_id'} })
db.reviews.update({recommend: {$in: ['true', 1]}}, {$set: {recommend: true}}, {multi: true})
db.reviews.update({recommend: {$in: ['false', 0]}}, {$set: {recommend: false}}, {multi: true})

# COUNTERS: create entry in counters collection
# reviews
db.counters.insertOne({seqName: 'review_id', value: 0})
# reviews_photos
db.counters.insertOne({seqName: 'review_photos_id', value: 0})
# characteristic_reviews
db.counters.insertOne({seqName: 'characteristic_reviews_id', value: 0})

# COUNTERS: find the current max value of each id
# reviews
db.reviews.aggregate(
  [
    {
      $group:
      {
        _id: null,
        maxReviewId: {$max: '$review_id'}
      }
    }
  ]
)
db.counters.insertOne({seqName: 'review_id', value: 5777922})
# reviews_photos
db.reviews_photos.aggregate(
  [
    {
      $group:
      {
        _id: null,
        maxReviewPhotoId: {$max: '$id'}
      }
    }
  ]
)
db.counters.insertOne({seqName: 'review_photos_id', value: 2742832})
# characteristic_reviews
db.characteristic_reviews.aggregate(
  [
    {
      $group:
      {
        _id: null,
        maxCharacteristicReviewId: {$max: '$id'}
      }
    }
  ]
)
db.counters.insertOne({seqName: 'characteristic_reviews_id', value: 19337415})

# COUNTERS: initialize the counters table with the max value of their respective IDs
# reviews
db.counters.update(
  {seqName: 'review_id'},
  {$set: {value: 5777922}}
)
# review_photos
db.counters.update(
  {seqName: 'review_photos_id'},
  {$set: {value: 2742832}}
)
# characteristic_reviews
db.counters.update(
  {seqName: 'characteristic_reviews_id'},
  {$set: {value: 19337415}}
)

# CREATE INDEXES
# reviews
db.reviews.createIndex({ product_id: 1 }, { name: 'query by product_id' })
# db.reviews.createIndex({ review_id: 1 }, { name: 'query by review_id' })
# reviews_photos
db.reviews_photos.createIndex({ review_id: 1 }, { name: 'query by review_id' })
# characteristics
db.characteristics.createIndex({ product_id: 1 }, { name: 'query by product_id' })
# characteristic_reviews
db.characteristic_reviews.createIndex({ characteristic_id: 1 }, { name: 'query by characteristic_id' })
db.characteristic_reviews.createIndex({ review_id: 1 }, { name: 'query by review_id' })


# delete a field in a collection
# db.example.update({}, {$unset: {words:1}} , {multi: true});




# embed photos url into the respective review document
# WARNING: TAKES A LONG TIME FOR LARGE COLLECTIONS
# DO NOT USE
# db.reviews.find({}).forEach(function(review) {
#   print(review.product_id);
#   var temp = [];
#   db.reviews_photos.find({ review_id: review.review_id }).forEach(function(photo) {
#     temp.push({ id: photo.id, url: photo.url});
#   });
#   review.photos = temp;
#   db.reviews.save(review);
# });