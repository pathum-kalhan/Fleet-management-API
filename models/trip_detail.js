'use strict';
module.exports = (sequelize, DataTypes) => {
  const trip_detail = sequelize.define('trip_detail', {
    tripId: {
      type: DataTypes.INTEGER,
      references: {
        model: "trips",
        key: 'id'
      },
      onDelete: 'cascade'
    },
    placeId: {
      type: DataTypes.INTEGER,
      references: {
        model: "places",
        key: 'id'
      },
      onDelete: 'cascade'
    },
  }, {});
  trip_detail.associate = function(models) {
    trip_detail.belongsTo(models.trip, { foreignKey: 'tripId' })
    trip_detail.belongsTo(models.place, { foreignKey: 'placeId' })
    // associations can be defined here
  };
  return trip_detail;
};