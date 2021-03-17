const readline = require('readline');
const fs = require('fs');
const path = require('path');
const db = require('../model/index.js');
const transform = require('../transform/index.js');

const file = path.resolve('test.csv');
const reviewsInterface = readline.createInterface({
  input: fs.createReadStream(file)
});

// reviewsInterface.on('close', () => {
//   reviewsInterface.close();
//   reviewsInterface.removeAllListeners();
//   console.log(`done`);
// });

const processLines = async () => {
  for await (const line of reviewsInterface) {
    if (line.split(',')[0] !== 'id') {
      const review = transform.reviews(line);
      const product_id = review.product_id;

      let test = await db.reviews.findProduct(product_id);
      console.log(1, test);
      if (!test) {
        await db.reviews.createProduct(product_id);
        test = await db.reviews.findProduct(product_id);
      }
      console.log(2, test)
    }
  }
};

processLines();