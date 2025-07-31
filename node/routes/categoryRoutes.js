const express = require('express');
const router = express.Router();

const { post, get } = require('../controller/categoryController');

router.post('/add', post);

router.get('/get', get);

module.exports = router;