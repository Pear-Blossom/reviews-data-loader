const { booleanConverter } = require('../utils/booleanConverter.js');
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

module.exports = review => {
  const reviewArray = review.split(',');

  const reviewObj = {
    review_id: reviewArray[0],
    product_id: reviewArray[1],
    rating: reviewArray[2],
    summary: reviewArray[4],
    recommend: booleanConverter(reviewArray[6]),
    reported: booleanConverter(reviewArray[7]),
    body: reviewArray[5],
    date: new Date(reviewArray[3]),
    reviewer_name: reviewArray[8],
    reviewer_email: reviewArray[9],
    helpfulness: reviewArray[11]
  };

  if (reviewArray[10] !== '') reviewObj.response = reviewArray[10];

  return reviewObj;
};
