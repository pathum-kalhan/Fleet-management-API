const jwt = require('jsonwebtoken');
const config = require('../../config/config');

module.exports = (req, res, next) => {
  try {
    const token = req.headers.authorization;
    const decoded = jwt.verify(token, config.JWT_KEY);
    req.user = decoded;
    return next();
  } catch (error) {
    return res.status(401).json({
      message: 'Auth failed',
    });
  }
};
