const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;

const User = require('../models/user');
const config = require('../config/config');

module.exports= function (passport) {
    var opts={};
    opts.secretOrKey = config.secret_key;
    opts.jwtFromRequest=ExtractJwt.fromAuthHeaderWithScheme('jwt');

    passport.use(new JwtStrategy(opts,(jwt_payload,done)=>{
       User.find({
           id:jwt_payload.id
       },(user,err)=>{
           if(err){
               return done(err,false);
           }else{
               return done(null,user);
           }
           
       })
         
    }));
    
    
};