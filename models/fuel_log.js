'use strict';
const moment = require('moment')
module.exports = (sequelize, DataTypes) => {
  const fuel_log = sequelize.define('fuel_log', {
    vehicleId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'vehicles',
        key: 'id'
      },
      allowNull: false,
      onDelete: 'cascade',
      onUpdate: 'cascade'
    },
    fuelLevel: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    createdAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('createdAt')).format('YYYY-MM-DD hh:mm:ss A')
      }
    },
    updatedAt: {
      allowNull: false,
      type: DataTypes.DATE
    },
    action: { type: DataTypes.ENUM("add", "remove") },
    details: {
      type: DataTypes.VIRTUAL,
      get() {
        const details = `${this.getDataValue('action')} ${this.getDataValue('fuelLevel')}`
        return details;
      }
    },
  }, {});
  fuel_log.associate = function(models) {
    fuel_log.belongsTo(models.vehicle, { foreignKey: 'vehicleId' })
    // associations can be defined here
  };
  return fuel_log;
};