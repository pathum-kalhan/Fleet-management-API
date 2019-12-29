'use strict';
const moment = require("moment")
module.exports = (sequelize, DataTypes) => {
  const audit = sequelize.define('audit', {
    area: {
      type: DataTypes.STRING,
      allowNull: false
    },
    action: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: {
      type: DataTypes.STRING,
      allowNull: false
    },
    userId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'users',
        key: 'id'
      },
      allowNull: false,
      onDelete: 'cascade',
      onUpdate: 'cascade'
    },
    refId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    createdAt: {
      allowNull: false,
      type: DataTypes.DATE,
      get() {
        return moment(this.getDataValue('createdAt')).format('YYYY-MM-DD hh:mm:ss A')
      }
    },
  }, {});
  audit.associate = function(models) {
    audit.belongsTo(models.user, { foreignKey:'userId'})
  };
  return audit;
};