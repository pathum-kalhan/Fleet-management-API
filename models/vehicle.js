'use strict';
const moment = require('moment')
module.exports = (sequelize, DataTypes) => {
  const vehicle = sequelize.define('vehicle', {
    make: {
      type: DataTypes.STRING
    },
    year: {
      type: DataTypes.INTEGER
    },
    color: {
      type: DataTypes.STRING
    },
    vin: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    tankVolume: {
      type: DataTypes.FLOAT
    },
    status: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    fuelLevel: {
      type: DataTypes.FLOAT
    },
    image: {
      type: DataTypes.STRING
    },
    notes: {
      type: DataTypes.STRING
    },
    categoryId: {
      type: DataTypes.INTEGER,

    },
    fuelPercentage: {
      type: DataTypes.VIRTUAL,
      get() {
        const percentage = parseFloat((this.getDataValue('fuelLevel') / this.getDataValue('tankVolume')) * 100).toFixed(2)
        if (percentage >= 75) {
          return {
            color: "green",
            percentage,
            text:"okay"
          }
        }
        else if (percentage >= 35) {
          return {
            color: "yellow",
            percentage,
            text: "normal"
          }
        } else {
          return {
            color: "red",
            percentage,
            text: "low"
          }
        }
      }
    },
    fuelType: { type: DataTypes.ENUM("petrol", "diesel") },
    createdAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('createdAt')).format('DD-MM-YYYY h:mm:ss');
      }
    },
    updatedAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('updatedAt')).format('DD/MM/YYYY h:mm:ss');
      }
    },
  }, {
     
  });
  vehicle.associate = function (models) {
    vehicle.belongsTo(models.category, { foreignKey: 'categoryId' })
    vehicle.hasMany(models.fuel_log, { foreignKey: 'vehicleId' })
    vehicle.hasMany(models.trip, { foreignKey: 'vehicleId' })
    vehicle.hasMany(models.maintenance, { foreignKey: 'vehicleId' })


  };
  return vehicle;
};