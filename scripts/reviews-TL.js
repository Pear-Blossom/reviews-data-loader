const readline = require('readline');
const fs = require('fs');
const path = require('path');
const db = require('../model/index.js');
const transform = require('../transform/index.js');

const file = path.resolve('test.csv');
const reviewsInterface = readline.createInterface({
  input: fs.createReadStream(file)
});

reviewsInterface.on('line', line => {
  if (line.split(',')[0] !== 'id') {
    const currentLine = transform.reviews(line);

    console.log(currentLine);
  }
});

reviewsInterface.on('close', () => {
  reviewsInterface.close();
  reviewsInterface.removeAllListeners();
  console.log(`done`);
});