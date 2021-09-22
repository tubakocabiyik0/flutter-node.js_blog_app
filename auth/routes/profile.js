const express = require('express');
const actions=require('../methods/actions');
const router = express.Router();


router.put('/updateUsername/:username',actions.updateProfile);
router.post('/addProfile',actions.addProfileInfos);
router.get('/getProfile',actions.getProfileInfos);
module.exports = router;