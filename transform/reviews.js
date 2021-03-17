const booleanConverter = require('../utils/booleanConverter.js');
// 0 id
// 1 product_id
// 2 rating
// 3 date
// 4 summary
// 5 body
// 6 recommend
// 7 reported
// 8 reviewer_name
// 9 reviewer_email
// 10 response
// 11 helpfulness

module.exports.reviews = review => {
  const reviewArray = review.split(',');

  const reviewObj = {
    review_id: reviewArray[0],
    rating: reviewArray[2],
    summary: reviewArray[4],
    recommend: booleanConverter(reviewArray[6]),
    reported: booleanConverter(reviewArray[7]),
    response: reviewArray[10],
    body: reviewArray[5],
    date:
  };
};
