const express = require('express');
const actions=require('../methods/actions');
const router = express.Router();


router.put('/update/:username',actions.updateProfile);
router.post('/addProfile',actions.addProfileInfos);
router.get('/getProfile',actions.getProfileInfos);
router.delete('/deleteProfile',actions.deleteProfile);
module.exports = router;