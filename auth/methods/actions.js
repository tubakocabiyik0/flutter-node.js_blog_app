const User = require('../models/user');
const jwt = require('jsonwebtoken');
const config = require('../config/db');
const configKey=require('../config/config');
const bcrypt=require('bcryptjs');
const Profile = require('../models/Profile');
let random=Math.floor(Math.random() * 10000).toString;

//const user = require('../models/user');

const functions ={
addNewUser: function (req,res) {
    const {username,password} = req.body;
  if((req.body.username === null) || (req.body.password) === null ){
    res.json({ success: false, msg: 'enter all fields' });

  }else{
   
    bcrypt.hash(password, 10).then((hash) => {
      const user = new User({
          username: username,
          password: hash
        });
    
      const promise = user.save();
      promise.then((newUser) => {
         
          res.json({success:true,newUser});
          
        }).catch((err)=>{
         res.json({success:false,msg: 'try another username'});
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
},

delete:(req,res)=>{
const{username,password}=req.body;
const promise =User.findOneAndDelete({username:username});
promise.then((result)=>{
if(result){
 res.json({success:true,msg:'Account deleted'});
}else{
  res.json({success:true,msg:'Account didnt delete'});
}
});

},

  update: (req, res) => {
  const promise = User.findOneAndUpdate(req.params.username,req.body,{new:true});
  promise.then((result)=>{
    if(result){
      res.json({success:true,msg:'updated'});
     }else{
       res.json({success:true,msg:' didnt updated'});
     }
  });


},
updateProfile:(req,res)=>{
    const promise = profile.findOneAndUpdate(req.params.username, req.body, { new: true });
    promise.then((result) => {
  if (result) {
    res.json({success:true,msg:'updated'});
  } else {
     res.json({success:true,msg:' didnt updated'});
  }
    });
},

addProfileInfos:(req,res)=>{
  const {username,password}=req.body;
  Profile.findOne({username:username}).then((result)=>{
  if(result){
    res.json({success:false,msg:'error'});
  }else{
    const profile = new Profile({
      username: username,
  
    })
    profile.save().then((result)=>{
    if(result!=null){
      res.json({success:true,msg:'loaded'});
    }else{
      res.json({success:false,msg:'error'});
    }
  
    });
  }
  });
 
},

getProfileInfos:(req,res)=>{
  const promise = Profile.find();
   promise.then((data)=>{
    if(data!=null){
      res.json({success:true,data:data});
      return data;
    }else{
      res.json({success:false,msg:'data dont find'});
    }
   })
},


}
module.exports=functions;