const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const profileSchema = new Schema({
    username:{
        type:String,
        required:true,
    },

    name:{
        type:String,
        required:false,
        default:"",
    },

    surname:{
        type:String,
        required:false,
        default:"",
    },
    
    image:{
        type:String,
        required:false,
        default:"https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png",
    }


});

module.exports=mongoose.model('profile',profileSchema);