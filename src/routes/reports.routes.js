const express = require('express');
const moment = require('moment');
const db = require('../../models');

const { Op } = db.Sequelize;

const router = express.Router();


router.post('/audits', async (req, res) => {
  try {
    const query = `SELECT 
    audits.*,
    CONCAT(users.firstName, ' ', users.lastName) AS name
FROM
    db_fleet.audits
        INNER JOIN
    users ON audits.userId = users.id
WHERE
    audits.userId IN (:ids)
        AND DATE(audits.createdAt) >= DATE(:date)`;
    const data = await db.sequelize.query(query,
      {
        replacements: { ids: req.body.ids, date: req.body.date },
        type: db.sequelize.QueryTypes.SELECT,
        logging: true,
      });
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
    });

    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.get('/roles', async (req, res) => {
  try {
    const query = 'SELECT role FROM db_fleet.users group by role;';
    const data = await db.sequelize.query(query,
      {

        type: db.sequelize.QueryTypes.SELECT,

      });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.post('/user', async (req, res) => {
  try {
    const query = {
      order: db.sequelize.literal(req.body.orderBy),
      where: {
        role: {
          [Op.in]: req.body.roles,
        },

      },
      raw: true,
    };
    if (req.body.status === 'Active') {
      query.where.status = true;
    }
    if (req.body.status === 'Inactive') {
      query.where.status = false;
    }
    const data = await db.user.findAll(query);
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
      e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.post('/category', async (req, res) => {
  try {
    const query = `SELECT 
    *
FROM
    db_fleet.categories
WHERE
    ${req.body.status === 'All' ? '' : `${req.body.status === 'Active' ? 'status = TRUE AND' : 'status = FALSE AND'}`}
         DATE(createdAt) >= DATE(:date)
        order by :order;`;
    //
    const data = await db.sequelize.query(query,
      {
        replacements: { order: req.body.orderBy, date: req.body.dateFrom },
        logging: true,
        type: db.sequelize.QueryTypes.SELECT,

      });

    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.post('/place', async (req, res) => {
  try {
    const query = `SELECT * FROM db_fleet.places where ${req.body.status === 'All' ? ''
      : `${req.body.status === 'Active' ? 'status = TRUE AND' : 'status = FALSE AND'}`} DATE(createdAt) >= DATE(:date)`;

    //
    const data = await db.sequelize.query(query,
      {
        replacements: { order: req.body.orderBy, date: req.body.dateFrom },
        logging: true,
        type: db.sequelize.QueryTypes.SELECT,

      });
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
      e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.post('/vehicle', async (req, res) => {
  try {
    const query = `SELECT 
    *
FROM
    db_fleet.vehicles
WHERE
    ${req.body.status === 'All' ? '' : `${req.body.status === 'petrol' ? 'status = "petrol" AND' : 'status = "diesel" AND'}`}
         categoryId IN (:ids)
        AND DATE(createdAt) >= DATE(:date)`;


    //
    const data = await db.sequelize.query(query,
      {
        replacements: { order: req.body.orderBy, date: req.body.date, ids: req.body.ids },
        logging: true,
        type: db.sequelize.QueryTypes.SELECT,

      });
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
      e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.post('/fuel', async (req, res) => {
  try {
    const query = `SELECT 
    vehicles.id,
    vehicles.make,
    vehicles.year,
    vehicles.color,
    vehicles.vin,
    vehicles.tankVolume,
    vehicles.fuelLevel,
    vehicles.fuelType,
    categories.name AS cat
FROM
    db_fleet.vehicles
        INNER JOIN
    categories ON vehicles.categoryId = categories.id
WHERE
    ${req.body.status === 'All' ? '' : `${req.body.status === 'Active' ? 'vehicles.status = true AND' : 'vehicles.status = false AND'}`}
         vehicles.categoryId IN (:ids)
ORDER BY ${req.body.orderBy};`;

    const data = await db.sequelize.query(query,
      {
        replacements: { order: req.body.orderBy, ids: req.body.ids },
        logging: true,
        type: db.sequelize.QueryTypes.SELECT,

      });
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
      e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});
router.post('/maintenance', async (req, res) => {
  try {
    const query = `SELECT 
    maintenances.*, vehicles.vin, categories.name
FROM
    db_fleet.maintenances
        INNER JOIN
    vehicles ON maintenances.vehicleId = vehicles.id
        INNER JOIN
    categories ON vehicles.categoryId = categories.id
WHERE
    categories.id IN (:ids)
        AND DATE_FORMAT(maintenances.createdAt, '%Y%m') = :month`;
    const data = await db.sequelize.query(query,
      {
        replacements: { month: req.body.month, ids: req.body.ids },
        logging: true,
        type: db.sequelize.QueryTypes.SELECT,

      });
    data.forEach((e) => {
      e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
      e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

router.post('/finance', async (req, res) => {
  try {
    const query = `(SELECT 
    id,
    'Trip allowance' AS t,
    allowances AS amount,
    DATE(createdAt) AS d
FROM
    db_fleet.trips
WHERE
    DATE(createdAt) >= DATE(:from)
        AND DATE(createdAt) <= DATE(:to)
        AND allowances > 0) UNION ALL (SELECT 
    id,
    'Maintenances job' AS t,
    payment AS amount,
    DATE(createdAt) AS d
FROM
    db_fleet.maintenances
WHERE
    DATE(createdAt) >= DATE(:from)
        AND DATE(createdAt) <= DATE(:to)
        AND payment > 0)`;
    const data = await db.sequelize.query(query,
      {
        replacements: { from: req.body.from, to: req.body.to },
        logging: true,
        type: db.sequelize.QueryTypes.SELECT,

      });


    // data.forEach((e) => {
    //   e.createdAt = moment(e.createdAt).format('YYYY-MM-DD hh:mm:ss A');
    //   e.updatedAt = moment(e.updatedAt).format('YYYY-MM-DD hh:mm:ss A');
    // });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});


router.post('/summaryR', async (req, res) => {
  try {
    const data = [];
    const query1 = `SELECT 
    COUNT(*) AS c
FROM
    db_fleet.audits
WHERE
    DATE(createdAt) >= DATE(:from)
        AND DATE(createdAt) <= DATE(:to)
GROUP BY userId;`;
    const usersActive = await db.sequelize.query(query1,
      {
        replacements: { from: req.body.from, to: req.body.to },

        type: db.sequelize.QueryTypes.SELECT,

      });


    console.log('users active', usersActive);
    data.push({ type: 'Users active', value: usersActive[0].c });
    const query2 = `SELECT 
    COUNT(*) AS c
FROM
    db_fleet.trips
WHERE
    DATE(createdAt) >= DATE(:from)
        AND DATE(createdAt) <= DATE(:to)`;
    const tripCreated = await db.sequelize.query(query2,
      {
        replacements: { from: req.body.from, to: req.body.to },

        type: db.sequelize.QueryTypes.SELECT,

      });
    console.log('trips created', tripCreated);
    data.push({ type: 'Trips created', value: tripCreated[0].c });
    const query3 = `SELECT 
    COUNT(*) AS c
FROM
    db_fleet.trips
WHERE
    DATE(updatedAt) >= DATE(:from)
        AND DATE(updatedAt) <= DATE(:to)`;
    const tripsUpdated = await db.sequelize.query(query3,
      {
        replacements: { from: req.body.from, to: req.body.to },

        type: db.sequelize.QueryTypes.SELECT,

      });
    console.log('trips updated', tripsUpdated);
    data.push({ type: 'Trips updated', value: tripsUpdated[0].c });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
});

module.exports = router;
