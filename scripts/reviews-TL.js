const readline = require('readline');
const fs = require('fs');
const path = require('path');
const db = require('../model/index.js');
const transform = require('../transform/index.js');

const file = path.resolve('data/reviews.csv');
const reviewsInterface = readline.createInterface({
  input: fs.createReadStream(file)
});

reviewsInterface.on('close', () => {
  console.log(`doneee`);
});

let start = Number(process.argv[2]);
let end = Number(process.argv[3]);

const processLines = async () => {
  for await (const line of reviewsInterface) {
    let reviewArray = line.split(',');
    if (reviewArray[0] !== 'id') {
      if (reviewArray[0] >= start && reviewArray[0] < end) {
        let review = transform.reviews(line.split(','));
        const product_id = review.product_id;
        const review_id = review.review_id;
        console.log(`~~ ${review_id}`);

        // create product document if product_id is not found
        let productDocument = await db.reviews.findProduct(product_id);
        if (!productDocument) productDocument = await db.reviews.createProduct(product_id);

        // create review document if review_id is not found
        reviewDocument = await db.reviews.createReview(review);

        productDocument.results.push(reviewDocument._id);
        await productDocument.save();
      }
    }
  }
};

processLines();