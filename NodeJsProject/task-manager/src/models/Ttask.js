const mongoose = require('mongoose')
const Teacher = require('../models/teacher')
const taskSchema1 = new mongoose.Schema({
    About: {
        type: String,
        trim: true
    },
    Education: {
        type: String,
        trim: true
    },
    instrument:{
        type: String,
        required:false,
        trim:true
    },
    Students:{
        type : Array,
        required:false,
        
        
        trim:false
    },
    BreakDate:{
        type :Array,
        required:false,
        trim:true

    },
    BreakTime:{
        type :Array,
        required:false,
        trim:true

    },
    NName:{
        type: String,
        unique: true,
        required:false
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'Teacher'
    },
    TimeS : {
      type: Array,
      required:false,
      trim:true,
      
    },
    CanceledS:{
        type:Array,
        required:false,
        trim:false
    },
    CanceledSD:{
        type:Array,
        required:false,
        trim:false
    },
    CanceledST:{
        type:Array,
        required:false,
        trim:false
    },
    CanceledSInstrument:{
        type : Array,
        required:false,
        trim:false,

    },
    ratings:{
        type:Array,
        required:false,
        trim:true
    },
    ratingAvg:{
        type:Array,
        required:false,
        trim:true
    },
    ratingAvgCC:{
        type:Array,
        required:false,
        trim:true
    },

    DateS:{
        type :Array,
        required:false,
        trim:true
    },
    CompS:{
        type:Array,
        required:false,
        trim:false

    },
    CompSD:{
        type:Array
    },
    CompST:{
        type:Array
    },
    CompSinstrument:{
        type:Array,
    },
    StudentImage:{
        type:Array
    },
    StudentImageCO:{
        type:Array
    },
    StudentImageCA:{
        type:Array
    }
  
    

}, {
    timestamps: true
})
// taskSchema.statics.FindEd = async (id)=>{
//     const user =await Task.findOne({_id:id})
    
//     console.log(user.Educatior)

    
//     }

const TTask = mongoose.model('TTask', taskSchema1)

module.exports = TTask