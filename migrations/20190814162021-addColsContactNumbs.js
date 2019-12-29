'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {

    return Promise.all([
      queryInterface.addColumn('users', 'contactNumber1', { type: Sequelize.STRING }),
      queryInterface.addColumn('users', 'contactNumber2', { type: Sequelize.STRING }),
      queryInterface.removeColumn('users', 'contactNumbers')

    ])


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
