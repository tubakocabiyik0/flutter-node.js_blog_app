const express = require('express');
const actions=require('../methods/actions');
const router = express.Router();



router.post('/addUser',actions.addNewUser);

router.post('/authentication',actions.authenticate);

router.get('/info',actions.getInfo);

router.delete('/deleteUser',actions.deleteUser);

router.put('/updateUser/:getUsername',actions.update);

module.exports = router;
