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

const products = mongoose.model('Products', productSchema);
const reviews = mongoose.model('Reviews', reviewsSchema);

module.exports.findProduct = product_id => products.findOne({ product_id });

module.exports.createProduct = product_id => products.create({ product_id });

const load = async review => {

}

module.exports.load = load;