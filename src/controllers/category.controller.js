const db = require('../../models');

const modelName = 'category';
async function create(req, res) {
  try {
    const isCategoryExsit = await db[modelName].findOne({
      where: {
        name: req.body.name,
      },
    });
    if (isCategoryExsit) {
      return res.status(422).json('Category already exist!');
    }
    const data = await db[modelName].create(req.body);
    await db.audit.create({
      area: 'Category',
      action: 'Create',
      description: `Created category ${req.body.name}`,
      userId: req.user.id,
      refId: data.dataValues.id,
    });
    return res.sendStatus(200);
  } catch (error) {
    return res.sendStatus(500);
  }
}

async function read(req, res) {
  try {
    const data = await db[modelName].findAll({ order: db.sequelize.literal('id desc') });
    res.status(200).json(data);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function update(req, res) {
  try {
    await db[modelName].update(req.body, {
      where: {
        id: req.params.id,
      },
    });
    await db.audit.create({
      area: 'Category',
      action: 'Update',
      description: `Update category ${req.body.name}`,
      userId: req.user.id,
      refId: req.params.id,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
}

async function readById(req, res) {
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
  create,
  read,
  update,
  readById,
};
