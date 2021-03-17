const readline = require('readline');
const fs = require('fs');
const path = require('path');
const db = require('../model/index.js');

const file = path.resolve('test.csv');
const reviewsInterface = readline.createInterface({
  input: fs.createReadStream(file)
});

reviewsInterface.on('line', line => console.log(`current line ${line}`));

reviewsInterface.on('close', () => {
  reviewsInterface.close();
  reviewsInterface.removeAllListeners();
  console.log(`done`);
});