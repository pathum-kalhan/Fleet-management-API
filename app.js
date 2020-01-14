/* eslint-disable no-console */
const express = require('express');

const app = express();
const bodyParser = require('body-parser');


app.use(bodyParser.json());
const morgan = require('morgan');
const cors = require('cors');
const compression = require('compression');

app.use(cors());
const Sequelize = require('sequelize');

const env = process.env.NODE_ENV || 'development';
const cron = require('node-cron');
const moment = require('moment');
const fs = require('fs');
const { spawn } = require('child_process');

const wstream = fs.createWriteStream('dumpfilename.sql');
const mysqldump = require('mysqldump');
const config = require('./config/config')[env];
// DB connection
const sequelize = new Sequelize(config.database, config.username, config.password, {
  host: 'localhost',
  dialect: 'mysql',
  logging: false,
});
sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch((err) => {
    console.error('Unable to connect to the database:', err);
  });
app.listen(3000, () => {
  console.log('Server started on port');
});
app.use(morgan('dev'));
app.use(compression());

// import from routes folder
const user = require('./src/routes/user.routes');
const common = require('./src/routes/common.routes');
const category = require('./src/routes/category.routes');
const vehicle = require('./src/routes/vehicle.routes');
const place = require('./src/routes/place.routes');
const trip = require('./src/routes/trip.routes');
const dashboard = require('./src/routes/dashboard.routes');
const maintenance = require('./src/routes/maintenance.routes');
const report = require('./src/routes/reports.routes');

app.use('/reports', report);
app.use('/user', user);
app.use('/category', category);
app.use('/common', common);
app.use('/vehicle', vehicle);
app.use('/place', place);
app.use('/trip', trip);
app.use('/dashboard', dashboard);
app.use('/maintenance', maintenance);

function run(fileName) {
  mysqldump({
    connection: {
      host: 'localhost',
      user: 'root',
      password: 'root',
      database: 'db_fleet',
    },
    dumpToFile: `backups/${fileName}`,
  });
}

cron.schedule('30 * * * *', () => {
  console.log('cron job run');
  const fileName = `${Date.now()}.sql`;
  run(fileName);
});


app.use('/', (req, res) => {
  res.sendStatus(404);
});
