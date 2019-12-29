'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('fuel_logs', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      vehicleId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'vehicles',
          key:'id'
        },
        allowNull: false,
        onDelete: 'cascade',
        onUpdate: 'cascade'
      },
      fuelLevel: {
        type: Sequelize.FLOAT,
        allowNull:false
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('fuel_logs');
  }
};