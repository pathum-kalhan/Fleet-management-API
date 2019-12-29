"use strict";
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable("users", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      firstName: {
        type: Sequelize.STRING,
        allowNull: false
      },
      lastName: {
        type: Sequelize.STRING,
        allowNull: false
      },
      gender: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
        defaultValue: true
      },
      email: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },
      password: {
        type: Sequelize.STRING,
        allowNull: false
      },
      profileImg: {
        type: Sequelize.STRING
      },
      nic: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },
      notes: {
        type: Sequelize.STRING
      },
      role: {
        type: Sequelize.ENUM("admin", "manager", "staff", "driver"),
        allowNull: false
      },
      address: {
        type: Sequelize.STRING
      },
      contactNumbers: {
        type: Sequelize.STRING
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
    return queryInterface.dropTable("users");
  }
};
