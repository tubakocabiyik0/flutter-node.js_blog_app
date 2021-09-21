const User = require('../models/user');
const jwt = require('jsonwebtoken');
const config = require('../config/db');
const configKey=require('../config/config');
const bcrypt=require('bcryptjs');
//const user = require('../models/user');

const functions ={
addNewUser: function (req,res) {
    const {username,password} = req.body;
  if((req.body.username === null) || (req.body.password) === null ){
      res.json({ success: false, msg: 'enter all fields' });

  }else{
   
    bcrypt.hash(password,10).then((hash)=>{
        const user = new User({
            username:username,
            password:hash
        });
        const promise = user.save();
        promise.then((newUser)=>{
         res.json({success:true,newUser});
        }).catch((err)=>{
         res.json({success:false,msg: 'try another usernama'});
        });
    })
  }
    
},
authenticate:(req,res,next)=>{
const {username,password} = req.body;
const promise= User.findOne({username:username});
promise.then((data)=>{
  if(data==null){
    res.json({success:false,msg:'User not found'});
  }else{
    bcrypt.compare(password,data.password).then((result)=>{
      if(result){
       const payload={
         username:username
       };
       const token = jwt.sign(payload,configKey.secret_key,{
         expiresIn:720
       });
       res.json({success:true,token:token});

      }else{
        res.json({success:false,msg:'password not true'});
      }
    });
  }
}).catch((err)=>{
res.json({success:false,msg:err});

});

},

getInfo:(req,res)=>{
 if(req.headers.authorization && req.headers.authorization.split(' ')[0] ==='Bearer'){
    var token=req.headers.authorization.split(' ')[1];
    var decodeToken = jwt.decode(token,configKey.secret_key);
    res.json({success:true,msg:decodeToken.username})
 }
}

}
module.exports=functions;