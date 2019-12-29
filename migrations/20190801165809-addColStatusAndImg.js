'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    

     
    return Promise.all([
      queryInterface.addColumn('places','status' ,{ type: Sequelize.BOOLEAN,defaultValue:true,allowNull:false }),
      queryInterface.addColumn('places','img', { type: Sequelize.STRING })
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
