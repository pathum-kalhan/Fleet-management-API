const express = require('express');

const router = express.Router();

const mysqldump = require('mysqldump');
const checkAuth = require('../util/auth');

router.post('/', checkAuth, async (req, res) => {
  try {
    const fileName = `${Date.now()}.sql`;
    mysqldump({
      connection: {
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'db_fleet',
      },
      dumpToFile: `backups/${fileName}`,
    });

    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(500);
  }
});

module.exports = router;
