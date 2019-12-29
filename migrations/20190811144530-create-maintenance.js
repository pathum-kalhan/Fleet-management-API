'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('maintenances', {
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
        onDelete: 'cascade',
        onUpdate: 'cascade',
        allowNull: false
        
      },
      payment: {
        type: Sequelize.FLOAT,
        allowNull:false
      },
      startFrom: {
        type: Sequelize.DATEONLY,
        allowNull:false
      },
      stopAt: {
        type: Sequelize.DATEONLY,
        allowNull: false
      },
      notes: {
        type:Sequelize.STRING
      },
      isPaid: {
        type: Sequelize.BOOLEAN,
        allowNull:false
      },
      imgUrl: {
        type: Sequelize.STRING,
        
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
    return queryInterface.dropTable('maintenances');
  }
};