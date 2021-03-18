module.exports.stringCleanse = string => {
  const regex = /\"/g;
  return string.replace(regex, '');
};