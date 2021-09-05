const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const schema= mongoose.Schema;

const UserSchema = new schema({
   username:{
       type:String,
       required:true,
       unique:true,
   },
   password:{
       type:String,
       required:true
   },

});


module.exports=mongoose.model('user',UserSchema);