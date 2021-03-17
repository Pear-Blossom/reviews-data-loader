const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/review-service', {useNewUrlParser: true, useUnifiedTopology: true});

module.exports = mongoose;