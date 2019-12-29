const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../../models');

const modelName = 'user';
const config = require('../../config/config');

async function signUp(req, res) {
  try {
    // check email has a registration
    const isUserExist = await db[modelName].findOne({
      where: {
        nic: req.body.nic,
      },
    });

    const isEmailExist = await db[modelName].findOne({
      where: {
        email: req.body.email,
      },
    });

    if (isUserExist) {
      return res.status(422).json('NIC already exists!');
    }

    if (isEmailExist) {
      return res.status(422).json('Email already exists!');
    }
    // hash the password using bcrypt lib
    const salt = bcrypt.genSaltSync(10);
    req.body.password = bcrypt.hashSync(req.body.password, salt);

    // create the user
    const data = await db[modelName].create(req.body);
    await db.audit.create({
      area: 'User',
      action: 'Create',
      description: `Created user ${req.body.firstName} ${req.body.lastName}`,
      userId: req.user.id,
      refId: data.dataValues.id,
    });
    return res.sendStatus(200);
  } catch (error) {
    return res.sendStatus(500);
  }
}

async function login(req, res) {
  try {
    // 1. check whether user exists and active
    const isUserExist = await db[modelName].findOne({
      where: {
        nic: req.body.nic,
        status: true,
      },
    });
    // if not exist
    if (!isUserExist) {
      return res.status(401).json("User doesn't exists!");
    }

    // 2. check whether password matches or not
    const isMatch = bcrypt.compareSync(req.body.password, isUserExist.password);
    if (!isMatch) {
      return res.status(401).json('Incorrect password!');
    }

    // 3. issue a JWT
    const { id } = isUserExist;
    const userName = `${isUserExist.gender ? 'Mr.' : 'Ms.'} ${isUserExist.firstName} ${isUserExist.lastName}`;
    const token = await jwt.sign({
      id,
    }, config.JWT_KEY);

    return res.status(200).json({ token, userName, role: isUserExist.role });
  } catch (error) {
    return res.sendStatus(500);
  }
}

async function getAllusers(req, res) {
  try {
    const data = await db[modelName].findAll({
      attributes: { exclude: ['password'] },
      order: db.sequelize.literal('id desc'),

    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function update(req, res) {
  try {
    await db[modelName].update(req.body, {
      fields: ['firstName', 'lastName', 'gender', 'email', 'profileImg', 'nic', 'notes', 'role', 'address', 'contactNumber1', 'contactNumber2'],
      where: {
        id: req.params.id,
      },
    });
    await db.audit.create({
      area: 'User',
      action: 'Update',
      description: `Updated user ${req.body.firstName} ${req.body.lastName}`,
      userId: req.user.id,
      refId: req.params.id,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function updatePassword(req, res) {
  try {
    // 1. check whether user exists and active
    const isUserExist = await db[modelName].findOne({
      where: {
        id: req.user.id,
      },
    });
    // if not exist
    if (!isUserExist) {
      return res.status(401).json("User doesn't exists!");
    }

    // 2. check whether password matches or not
    const isMatch = bcrypt.compareSync(req.body.oldPassword, isUserExist.password);
    if (!isMatch) {
      return res.status(401).json('Old password doesn\'t matches!');
    }

    // hash the password using bcrypt lib
    const salt = bcrypt.genSaltSync(10);
    req.body.newPassword = bcrypt.hashSync(req.body.newPassword, salt);

    await db[modelName].update({
      password: req.body.newPassword,
    },
    {
      where: {
        id: req.user.id,
      },
    });

    return res.sendStatus(200);
  } catch (error) {
    return res.sendStatus(500);
  }
}

async function getReadById(req, res) {
  try {
    const data = await db[modelName].findOne({
      where: {
        id: req.params.id,
      },
    });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
}

module.exports = {
  signUp,
  getAllusers,
  login,
  update,
  updatePassword,
  getReadById,
};
