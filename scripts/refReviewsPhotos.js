const fs = require('fs');
const path = require('path');
const mongoose = require('../db/index.js');

const reviewsSchema = mongoose.Schema({
  review_id: Number,
  product_id: Number,
  rating: Number,
  summary: String,
  recommend: Boolean,
  reported: Boolean,
  response: String,
  body: String,
  date: Date,
  reviewer_name: String,
  reviewer_email: String,
  helpfulness: Number,
  photos: [{ type: mongoose.Schema.Types.ObjectId, ref: 'reviews_photos' }],
});

const reviewsPhotosSchema = mongoose.Schema({
  id: Number,
  review_id: Number,
  url: String,
});

const Reviews = mongoose.model('reviews', reviewsSchema);
const ReviewsPhotos = mongoose.model('reviews_photos', reviewsPhotosSchema);

(async () => {
  const reviewsPhotos = await ReviewsPhotos.find({}).select({ review_id: 1, url: 1 });
  reviewsPhotos.forEach(async photo => {
    const review = await Reviews.find({ review_id: reviewsPhotos.review_id });
    console.log(review);
  });
})();