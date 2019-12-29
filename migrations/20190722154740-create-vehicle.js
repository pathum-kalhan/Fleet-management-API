'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('vehicles', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      make: {
        type: Sequelize.STRING
      },
      year: {
        type: Sequelize.INTEGER
      },
      color: {
        type: Sequelize.STRING
      },
      vin: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },
      tankVolume: {
        type: Sequelize.FLOAT
      },
      status: {
        type: Sequelize.BOOLEAN,
        defaultValue: true
      },
      fuelLevel: {
        type: Sequelize.FLOAT
      },
      image: {
        type: Sequelize.STRING
      },
      notes: {
        type: Sequelize.STRING
      },
      categoryId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'categories',
          key: 'id'
        },
        onDelete: 'cascade'
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
    return queryInterface.dropTable('vehicles');
  }
};