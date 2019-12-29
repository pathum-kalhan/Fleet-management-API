"use strict";
module.exports = (sequelize, DataTypes) => {
  const user = sequelize.define(
    "user",
    {
      firstName: {
        type: DataTypes.STRING,
        allowNull: false
      },
      lastName: {
        type: DataTypes.STRING,
        allowNull: false
      },
      gender: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: true
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
      },
      password: {
        type: DataTypes.STRING,
        allowNull: false
      },
      profileImg: {
        type: DataTypes.STRING
      },
      nic: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
      },
      notes: {
        type: DataTypes.TEXT
      },
      role: {
        type: DataTypes.ENUM("admin", "manager", "staff", "driver"),
        allowNull: false
      },
      address: {
        type: DataTypes.TEXT
      },
      contactNumber1: {
        type: DataTypes.STRING
      },
      contactNumber2: {
        type: DataTypes.STRING
      },
      status: {
        type: DataTypes.BOOLEAN,
        defaultValue: true,
        allowNull: false
      },
      fullName: {
        type: DataTypes.VIRTUAL,
        get() {
          const name = `${this.getDataValue('gender')==true?"Mr. ":"Ms. "} ${this.getDataValue('firstName')} ${this.getDataValue('lastName')}`
          return name;
        }
      },
    },
    {}
  );
  user.associate = function (models) {
    user.hasMany(models.audit, { foreignKey: 'userId' })
    user.hasMany(models.trip, { foreignKey: 'driverId' })

  };
  return user;
};
