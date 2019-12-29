const db = require('../../models');

async function changeStatus(req, res) {
  try {
    await db[req.body.model_name].update({
      status: req.body.status,
    }, {
      where: {
        id: req.body.id,
      },
      logging: true,
    });
    await db.audit.create({
      area: req.body.model_name,
      action: 'Update',
      description: `Updated ${req.body.model_name} ${req.body.id} to ${req.body.status}`,
      userId: req.user.id,
      refId: req.body.id,
    });
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
}

module.exports = {

  changeStatus,
};
