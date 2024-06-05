const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();
const port = 4500;

// Middleware to parse JSON bodies
app.use(bodyParser.json());

// MongoDB connection string
const mongoUri = 'mongodb://localhost:27017/rango';

// Connect to MongoDB using Mongoose
mongoose.connect(mongoUri, {
 
});

const db = mongoose.connection;

db.on('error', (error) => {
  console.error('Connection error:', error);
});

db.once('open', () => {
  console.log('Connected to MongoDB');
});

// Define a schema and model
const dataSchema = new mongoose.Schema({
  filename: String,
  host: String,
  key: String,
});

const Data = mongoose.model('Data', dataSchema);

// POST endpoint to store data
app.post('/data', async (req, res) => {
  try {
    const data = new Data(req.body);
    const savedData = await data.save();
    res.status(204).send({});
  } catch (error) {
    res.status(500).send({ error: 'Failed to insert data' });
  }
});

// GET endpoint to retrieve data
app.get('/data', async (req, res) => {
  try {
    const data = await Data.find({});
    res.status(200).send(data);
  } catch (error) {
    res.status(500).send({ error: 'Failed to retrieve data' });
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
