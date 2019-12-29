'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {

    return Promise.all([queryInterface.changeColumn('users', 'notes', { type: Sequelize.TEXT }), queryInterface.changeColumn('users', 'address', { type: Sequelize.TEXT })])

  },

  down: (queryInterface, Sequelize) => {
    /*
      Add reverting commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.dropTable('users');
    */
  }
};
