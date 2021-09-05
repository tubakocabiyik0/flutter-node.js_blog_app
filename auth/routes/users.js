const express = require('express');
const actions=require('../methods/actions');
const router = express.Router();



router.post('/addUser',actions.addNewUser);

router.post('/authentication',actions.authenticate);

router.get('/info',actions.getInfo);


module.exports = router;
