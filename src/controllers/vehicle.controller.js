const moment = require('moment');
const db = require('../../models');

const modelName = 'vehicle';
async function create(req, res) {
  try {
    const isExsit = await db[modelName].findOne({
      where: {
        vin: req.body.vin,
      },
    });
    if (isExsit) {
      return res.status(422).json("VIN can't be duplicated!");
    }
    await db[modelName].create(req.body);
    await db.audit.create({
      area: 'Vehicle',
      action: 'Create',
      description: `Created vehicle ${req.body.vin}`,
      userId: req.user.id,
      refId: req.body.vin,
    });
    return res.sendStatus(200);
  } catch (error) {
    return res.sendStatus(500);
  }
}

async function read(req, res) {
  function myMapping(element) {
    const el = element;
    el.createdAt = moment(el.createdAt).format('YYYY-DD-MM h:mm:ss');

    el.updatedAt = moment(el.updatedAt).format('YYYY-DD-MM h:mm:ss');
    return el;
  }
  try {
    const data = await db[modelName].findAll({
      include: [{
        model: db.category,
        attributes: ['name'],
      }],

      order: db.sequelize.literal('id desc'),


    });

    data.map(myMapping);
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function update(req, res) {
  try {
    await db[modelName].update(req.body, {
      where: {
        id: req.params.id,
      },
    });
    await db.audit.create({
      area: 'Vehicle',
      action: 'Update',
      description: `Updated vehicle ${req.body.vin}`,
      userId: req.user.id,
      refId: req.body.vin,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function readById(req, res) {
  try {
    const data = await db[modelName].findOne({
      where: {
        id: req.params.id,
      },
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function updateFuelLevel(req, res) {
  try {
    const amount = parseFloat(req.body.fuelLevel);
    const id = Number(req.params.id);
    const query = `UPDATE db_fleet.vehicles 
SET 
    fuelLevel = fuelLevel + :amount
WHERE
    id = :id;`;
    await db.sequelize.query(query,
      { replacements: { amount, id }, type: db.sequelize.QueryTypes.UPDATE });
    const data = await db.fuel_log.create({
      fuelLevel: amount,
      vehicleId: id,
      action: 'add',
    });
    await db.audit.create({
      area: 'Fuel',
      action: 'Add',
      description: `Added ${amount} liters`,
      userId: req.user.id,
      refId: data.dataValues.id,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function fuelLogs(req, res) {
  try {
    const data = await db.fuel_log.findAll({
      include: [{ model: db.vehicle }],
      order: db.sequelize.literal('id DESC'),
      logging: true,
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
}

module.exports = {
  create,
  read,
  update,
  readById,
  updateFuelLevel,
  fuelLogs,
};
