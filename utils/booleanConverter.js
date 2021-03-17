module.exports.booleanConverter = value => {
  if (value === 'true') return true;
  if (value === 'false') return false;
  return null;
};