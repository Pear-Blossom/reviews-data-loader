const { stringCleanse } = require('../utils/stringCleanse.js');
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

module.exports = reviewArray => {

  const reviewObj = {
    review_id: reviewArray[0],
    product_id: reviewArray[1],
    rating: reviewArray[2],
    summary: stringCleanse(reviewArray[4]),
    recommend: stringCleanse(reviewArray[6]),
    reported: stringCleanse(reviewArray[7]),
    body: stringCleanse(reviewArray[5]),
    date: new Date(stringCleanse(reviewArray[3])),
    reviewer_name: stringCleanse(reviewArray[8]),
    reviewer_email: stringCleanse(reviewArray[9]),
    helpfulness: reviewArray[11]
  };

  if (reviewArray[10] !== '') reviewObj.response = stringCleanse(reviewArray[10]);

  return reviewObj;
};
