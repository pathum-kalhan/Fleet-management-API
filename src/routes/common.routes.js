const express = require('express');

const router = express.Router();
const controller = require('../controllers/common.controller');
const checkAuth = require('../util/auth');


router.put('/', checkAuth, controller.changeStatus);

module.exports = router;
