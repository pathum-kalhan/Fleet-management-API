const db = require('../../models');

const modelName = 'trip';
async function create(req, res) {
  try {
    const errors = [];
    // check if driver is assigned to a job
    const findDriverQuery = `SELECT 
    *
FROM
    db_fleet.trips
WHERE
    (DATE(startFrom) >= DATE(:startFrom))
        AND (DATE(stopAt) >= DATE(:stopAt))
        AND driverId = :driverId
        AND status IN ('pending' , 'ongoing')`;

    const isDriverAssigned = await db.sequelize.query(findDriverQuery,
      {
        replacements: {
          startFrom: req.body.startFrom,
          stopAt: req.body.stopAt,
          driverId: req.body.driverId,
        },
        type: db.sequelize.QueryTypes.SELECT,
      });

    if (isDriverAssigned.length) {
      errors.push('Driver is assigned');
    }

    // check if vehicle is assigned to a job
    const findVehicleAvailabilityQuery = `SELECT 
    *
FROM
    db_fleet.trips
WHERE
    (DATE(startFrom) >= DATE(:startFrom))
        AND (DATE(stopAt) >= DATE(:stopAt))
        AND vehicleId = :vehicleId
        AND status IN ('pending' , 'ongoing')`;

    const isVehicleAssigned = await db.sequelize.query(findVehicleAvailabilityQuery,
      {
        replacements:
        {
          startFrom: req.body.startFrom,
          stopAt: req.body.stopAt,
          vehicleId: req.body.vehicleId,
        },
        type: db.sequelize.QueryTypes.SELECT,
      });

    if (isVehicleAssigned.length) {
      errors.push('Vehicle is assigned');
    }

    if (errors.length) {
      return res.status(422).json(errors);
    }

    const data = await db[modelName].create(req.body);
    const details = [];
    req.body.selectedPlaces.forEach((element) => {
      details.push({
        tripId: data.dataValues.id,
        placeId: element,
      });
    });
    await db.trip_detail.bulkCreate(details);
    await db.audit.create({
      area: 'Trip',
      action: 'Create',
      description: `Created trip ${data.dataValues.id}`,
      userId: req.user.id,
      refId: data.dataValues.id,
    });
    return res.sendStatus(200);
  } catch (error) {
    return res.sendStatus(500);
  }
}

async function read(req, res) {
  try {
    // update before read
    const updateQuery = `UPDATE db_fleet.trips 
SET 
    status = 'expired'
WHERE
    status = 'pending'
        AND DATE(createdAt) < DATE(NOW())`;

    await db.sequelize.query(updateQuery,
      {

        type: db.sequelize.QueryTypes.UPDATE,
      });
    const user = await db.user.findOne({
      where: {
        id: req.user.id,
      },
      raw: true,
    });
    const query = {
      include: [
        { model: db.vehicle, attributes: ['vin'] },
        { model: db.user, attributes: ['fullName', 'gender', 'firstName', 'lastName'] },
        { model: db.trip_detail, include: [{ model: db.place }] },
      ],
      order: db.sequelize.literal('id desc'),
    };
    if (user.role === 'driver') {
      query.where = {};
      query.where.driverId = req.user.id;
    }

    const data = await db[modelName].findAll(query).map(e => e.get({ plain: true }))
      .map((el) => {
        let places = '';
        el.trip_details.forEach((elm) => {
          places = `${places} ${elm.place.name}`;
        });
        el.places = places;
        return el;
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
