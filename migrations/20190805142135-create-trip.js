'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('trips', {
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
          key: 'id'
        },
        onDelete: 'cascade'
      },
      driverId: {
        type: Sequelize.INTEGER,

        references: {
          model: 'users',
          key: 'id'
        },
        onDelete: 'cascade'
      },
      startFrom: {
        type: Sequelize.DATEONLY,
        allowNull: false,

      },
      stopAt: {
        type: Sequelize.DATEONLY,
        allowNull: false,
      },
      notes: {
        type: Sequelize.STRING
      },
      allowances: {
        type: Sequelize.DOUBLE
      },
      status: {
        type: Sequelize.ENUM('pending', 'ongoing', 'canceled', 'finished', 'expired'),
        defaultValue: 'pending',
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
    return queryInterface.dropTable('trips');
  }
};