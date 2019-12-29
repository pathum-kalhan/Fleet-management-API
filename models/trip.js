'use strict';
const moment = require('moment')

module.exports = (sequelize, DataTypes) => {
  const trip = sequelize.define('trip', {
    vehicleId: {
      type: DataTypes.INTEGER,

      references: {
        model: 'vehicles',
        key: 'id'
      },
      onDelete: 'cascade'
    },
    driverId: {
      type: DataTypes.INTEGER,

      references: {
        model: 'users',
        key: 'id'
      },
      onDelete: 'cascade'
    },
    startFrom: {
      type: DataTypes.DATEONLY,
      allowNull: false,

    },
    stopAt: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    notes: {
      type: DataTypes.STRING
    },
    allowances: {
      type: DataTypes.DOUBLE
    },
    status: {
      type: DataTypes.ENUM('pending', 'ongoing', 'canceled', 'finished', 'expired'),
      defaultValue: 'pending',
      allowNull: false
    },
    createdAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('createdAt')).format('DD/MM/YYYY h:mm:ss');
      }
    },
  }, {});
  trip.associate = function(models) {
    trip.belongsTo(models.vehicle, { foreignKey: 'vehicleId' })
    trip.belongsTo(models.user, { foreignKey: 'driverId' })
    trip.hasMany(models.trip_detail, { foreignKey: 'tripId' })

    // associations can be defined here
  };
  return trip;
};