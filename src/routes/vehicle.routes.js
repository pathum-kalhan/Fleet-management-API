const express = require('express');

const router = express.Router();
const controller = require('../controllers/vehicle.controller');

const db = require('../../models');
const checkAuth = require('../util/auth');


router.post('/', checkAuth, controller.create);
router.put('/:id', checkAuth, controller.update);
router.put('/fuel/:id', checkAuth, checkAuth, controller.updateFuelLevel);
router.get('/', checkAuth, controller.read);
router.get('/fuel', checkAuth, controller.fuelLogs);
router.get('/:id', checkAuth, controller.readById);
router.put('/fuelremove/:id', checkAuth, checkAuth, async (req, res) => {
  try {
    const amount = parseFloat(req.body.fuelLevel);
    const id = Number(req.params.id);
    const query = `UPDATE db_fleet.vehicles 
SET 
    fuelLevel = fuelLevel - :amount
WHERE
    id = :id;`;
    await db.sequelize.query(query,
      { replacements: { amount, id }, type: db.sequelize.QueryTypes.UPDATE });
    const data = await db.fuel_log.create({
      fuelLevel: amount,
      vehicleId: id,
      action: 'remove',
    });
    await db.audit.create({
      area: 'Fuel',
      action: 'Remove',
      description: `Removed ${amount} liters from ${data.dataValues.id}`,
      userId: req.user.id,
      refId: data.dataValues.id,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
});
module.exports = router;
