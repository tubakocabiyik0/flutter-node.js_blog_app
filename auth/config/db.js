const mongoose = require('mongoose');
const config= require('./config');

const dbConnetion = async ()=>{
    try{ 
     const connection=await mongoose.connect(config.database,{useNewUrlParser:true}).then(()=>{
         console.log("connection is succesful");

     });
     console.log("connection is succesful");
    }catch(err){
      console.log(err);
    }
} 

module.exports=dbConnetion;