const mongoose = require('../db/index.js');

/** Fields
 * id - Number
 * product_id - Number
 * rating - Number
 * date - Date
 * summary - String
 * body - String
 * recommend - Boolean
 * reported - Boolean
 * reviewer_name - String
 * reviewer_email - String
 * response - String
 * helpfulness - Number
 */

const productSchema = mongoose.Schema({
  product_id: Number,
  reviews: Array
});

const reviewsSchema = mongoose.Schema({
  review_id: Number,
  rating: Number,
  summary: String,
  recommend: Boolean,
  reported: Boolean,
  response: String,
  body: String,
  date: Date,
  reviewer_name: String,
  reviewer_email: String,
  helpfulness: Number
});

const reviews = mongoose.model('Reviews', reviewsSchema);

const load = (product_id, review) => {
  // product: initialize a variable which will represent the product document

  // add a check to see if there are commas within text to "&#44;"

  // first see if the product document exists
    // if exists
      // set the product variable to the found product document
    // if not exists
      // create a new product document
      // set the product variable to the new product document

  //
}

module.exports.load = load;