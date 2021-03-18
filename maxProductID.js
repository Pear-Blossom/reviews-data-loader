const readline = require('readline');
const fs = require('fs');
const path = require('path');

console.log(process.argv[2]);
console.log(Number(process.argv[3]));

// const file = path.resolve('data/reviews.csv');
// const reviewsInterface = readline.createInterface({
//   input: fs.createReadStream(file)
// });

// const processLines = async () => {
//   let max = 0;
//   for await (const line of reviewsInterface) {
//     if (line.split(',')[0] !== 'id') {
//       let review = line.split(',');
//       console.log(review[1]);
//       if (review[1] > max) max = review[1]
//     }
//   }
//   return max;
// };

// console.log('max', processLines());