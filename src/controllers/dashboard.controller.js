const db = require('../../models');

const { Op } = db.Sequelize;
async function dashboardSummary(req, res) {
  try {
    const [onGoingTrips,
      pendingTrips,
      drivers,
      driversActive,
      vehicles,
      audits,
      totalVehicles,
      totalDrivers,
    ] = await Promise.all([
      db.trip.count({
        where: {
          status: 'ongoing',
        },
      }),
      db.trip.count({
        where: {
          status: 'pending',
        },
      }),
      db.user.count({
        logging: true,
        where: {
          role: 'driver',
          status: true,
        },
      }),
      db.trip.count({
        logging: true,
        distinct: true,
        col: 'driverId',
        where: {

          status: {
            [Op.in]: ['pending', 'ongoing'],
          },
        },
      }),
      db.vehicle.count({
        where: {

          status: true,
        },
      }),
      db.audit.findAll({
        limit: 100,
        order: db.sequelize.literal('id desc'),
        include: [{ model: db.user, attributes: ['id', 'firstName', 'lastName', 'gender', 'fullName'] }],
      }),
      db.vehicle.count(),
      db.user.count({
        where: {
          role: 'driver',
        },
      }),
    ]);


    res.status(200).json({
      onGoingTrips,
      pendingTrips,
      drivers,
      driversActive,
      vehicles,
      audits,
      totalVehicles,
      totalDrivers,
    });
  } catch (error) {
    res.sendStatus(500);
  }
}

module.exports = {
  dashboardSummary,
};
