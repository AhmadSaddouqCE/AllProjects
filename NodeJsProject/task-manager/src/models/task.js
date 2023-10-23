const mongoose = require('mongoose')

var taskSchema = new mongoose.Schema({
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
    Name: {
        type:String,
        unique:true,
        required:false

    },
    CartName:{
        type:Array,
        required:false,
        trim:true,
    },
    CartImage:{
        type:Array
    },
    CartQuantity:{
      type:Array,
      required:false,
      trim:true
    },
    CartPrice:{
        type:Array,
        required:false,
        trim: true
    },
    CartDoneQuantity:{
        type:Array
    },
    CartDonePrice:{
        type:Array
    },
    CartDoneImage:{
        type:Array
    },
    CartOwns:{
        type:Array,
        required:false,
        trim:true
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    },
 
    Time:{
      type: String,
      required:false,
      trim:true

    },
    owner2:{
        type: mongoose.Schema.Types.String,
        required: false,
        ref: 'Teacher'
    },
    rating:{
        type:Number,
        required:false,
        trim:true
    },
   
    Date:{
        type:String,
        required:false,
        trim:true
    },
    HelpResponced:{
        type: Array,
          required:false,
          trim:true
    },
    toggle:{
        type:String,
        required:false,
        trim:true
    },
    toggleM:{
        type:String
    },
    toggleS:{
        type:String
    }

     

}, {
    timestamps: true
    
})
// taskSchema.statics.FindEd = async (id)=>{
//     const user =await Task.findOne({_id:id})
    
//     console.log(user.Educatior)

    
//     }
taskSchema.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    delete userObject.password
    delete userObject.tokens
    if(userObject.CartImage){
        userObject.CartImage=userObject.CartImage.toString("base64")
    }

    return userObject
}

const Task = mongoose.model('Task', taskSchema)

module.exports = Task