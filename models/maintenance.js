'use strict';
module.exports = (sequelize, DataTypes) => {
  const maintenance = sequelize.define('maintenance', {
    vehicleId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'vehicles',
        key: 'id'
      },
      onDelete: 'cascade',
      onUpdate: 'cascade',
      allowNull: false

    },
    payment: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    startFrom: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    stopAt: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    notes: {
      type: DataTypes.STRING
    },
    isPaid: {
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    imgUrl: {
      type: DataTypes.STRING,

    },
  }, {});
  maintenance.associate = function(models) {
    maintenance.belongsTo(models.vehicle, { foreignKey: 'vehicleId' })
    // associations can be defined here
  };
  return maintenance;
};