const express = require('express');

const router = express.Router();
const controller = require('../controllers/maintenance.controller');

const checkAuth = require('../util/auth');

router.post('/', checkAuth, controller.create);
router.put('/:id', checkAuth, controller.update);
router.get('/', checkAuth, controller.read);
router.get('/:id', checkAuth, controller.readById);
module.exports = router;
