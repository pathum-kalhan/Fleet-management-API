const express = require('express');

const router = express.Router();
const controller = require('../controllers/user.controller');
const checkAuth = require('../util/auth');

router.get('/', checkAuth, controller.getAllusers);
router.get('/:id', checkAuth, controller.getReadById);
router.post('/signup', checkAuth, controller.signUp);
router.post('/login', controller.login);
router.put('/password', checkAuth, controller.updatePassword);
router.put('/:id', checkAuth, controller.update);
module.exports = router;
