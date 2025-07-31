const express = require('express');
const app = express();
const connectDB = require('./config/db');
const List = require('./routes/listRoutes');
const Category = require('./routes/categoryRoutes')
require('dotenv').config();

const port = process.env.PORT || 5000;

connectDB();

app.use(express.json());

app.use('/', List);

app.use('/category', Category);

app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});