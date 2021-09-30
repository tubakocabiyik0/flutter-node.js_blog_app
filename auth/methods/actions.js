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
        const token = jwt.sign(payload, configKey.secret_key, {
         expiresIn: 720
       });
        res.json({ success: true, token: token });

      } else {
        res.json({ success: false, msg: 'password not true' });
      }
    });
  }
}).catch((err) => {
  res.json({ success: false, msg: err });

});

  },

  getInfo: (req, res) => {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
      var token = req.headers.authorization.split(' ')[1];
      var decodeToken = jwt.decode(token, configKey.secret_key);
      res.json({ success: true, msg: decodeToken.username })
    }
  },

  deleteUser: (req, res) => {
  const { username, password } = req.body;
  const promise = User.findOneAndDelete({ username: username });
  promise.then((result) => {
  if (result) {
  res.json({ success: true, msg: 'Account deleted' });
} else {
  res.json({ success: true, msg: 'Account didnt delete' });
}
});

  },
  deleteProfile: (req, res) => {
    const { username } = req.body;
    const promise = Profile.findOneAndDelete({ username: username });
    promise.then((result) => {
    if (result) {
    res.json({ success: true, msg: 'Account deleted' });
  } else {
    res.json({ success: true, msg: 'Account didnt delete' });
  }
  });
  
    },


  update: async(req, res) => {
    const { username } = req.body;
    await User.findOne({ username: username }).then((result) => {
    
      if (result == null) {
        User.findOneAndUpdate( {username:req.params.getUsername},{username:req.body.username}).then((result) => {
         
         return res.json({ success: true, msg: 'updated' });
     
      }).catch((err)=>{
        return res.json({ success: false, msg: err });
      });   
    
      } else {
        res.json({ success: false, msg: ' This username cant usable' });
      }
    }); 


  


},
  updateProfile: (req, res) => {
    const { username,name, surname ,image } = req.body;
    Profile.findOne({ username: username }).then((result) => {
      if (result == null) {
       Profile.findOneAndUpdate({username:req.params.username}, {username:username,name:name,surname:surname,image:image}).then((result) => {
           
            res.json({ success: true, msg: 'updated' });
           
        }).catch((err)=>{
          return res.json({ success: false, msg: err });
        });
      }  else{
        res.json({ success: false, msg: ' This username using' });
      }
})},

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