'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('users', [{
      firstName: 'Lahiru',
      lastName: 'Bandara',
      email: 'ulb1994@gmail.com',
      password: '$2a$10$gH1mfn2jqp6xq7gSVn.FAO8oh4Mcw6kd2nL/0GKFAaaNiDau3JsNm',
      nic: '961962666V',
      role: 'admin',
      createdAt: new Date(),
      updatedAt: new Date()
    }]);
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
