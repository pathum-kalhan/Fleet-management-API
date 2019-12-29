'use strict';
const moment = require('moment')
module.exports = (sequelize, DataTypes) => {
  const place = sequelize.define('place', {
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    address: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    notes: {
      type: DataTypes.TEXT,
    },
    lat: {
      type: DataTypes.DOUBLE,
      unique: 'uniqueplace'
    },
    lng: {
      type: DataTypes.DOUBLE,
      unique: 'uniqueplace'
    },
    createdAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('createdAt')).format('DD/MM/YYYY h:mm:ss');
      }
    },
    updatedAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('updatedAt')).format('DD/MM/YYYY h:mm:ss');
      }
    },
    status: { type: DataTypes.BOOLEAN, defaultValue: true, allowNull: false },
    img: { type: DataTypes.STRING }
  }, {});
  place.associate = function(models) {
    place.hasMany(models.trip_detail, { foreignKey: 'placeId' })
  };
  return place;
};