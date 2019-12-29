const moment = require('moment');
const db = require('../../models');

const modelName = 'maintenance';
async function create(req, res) {
  try {
    await db[modelName].create(req.body);
    await db.audit.create({
      area: 'Maintenance',
      action: 'Create',
      description: `Add job to ${req.body.vehicleId}`,
      userId: req.user.id,
      refId: req.body.vehicleId,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function read(req, res) {
  try {
    const data = await db[modelName].findAll({
      raw: true,
      logging: true,
      order: db.sequelize.literal('DATE(maintenance.createdAt) DESC'),
      include: [{ model: db.vehicle }],
    });
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
      e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    });
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

module.exports = {
  create,
  read,
  update,
  readById,
};
