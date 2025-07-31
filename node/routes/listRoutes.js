const express = require('express');
const router = express.Router();

const { post, get, updateList, deleteList } = require('../controller/listController');

router.post('/addList', post);

router.get('/getList', get);

router.put('/updateList/:id', updateList);

router.delete('/deleteList/:id', deleteList);

module.exports = router;