const mongoose = require('mongoose')
const validator = require('validator')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')
const Task = require('./task')
// const TTask = require('./Ttask')

const Teacher = require('./teacher')
const userSchema = new mongoose.Schema({ 
    Phone:{
    type : String,
    unique:true,
    required: false,
    trim: true,
    minlength: 10,
    },

    Gender:{
        type: String,
        required: true,
        trim:true
          
    },
    
  
      name: {
          type: String,
          unique:true,
          required: true,
          trim: true,
          minlength:5,
          
          
      },
      email: {
          type: String,
          required: true,
          trim: true,
          unique: true,
          lowercase: true,
        
      },
      birthday:{
          type: String,
          required: true,
          trim:true,
         
  
      },
      password: {
          type: String,
          required: true,
          minlength: 7,
          trim: true,
        
      },
      ConfPass: {
        type: String,
        required: false,
        minlength:7,
        trim:true
  
      },
      owner1: {
        type: mongoose.Schema.Types.String,
        required: false,
        ref: 'Teacher'
    },
      Tries: {
       type : Number

      },

      tokens: [{
        token: {
            type: String,
            required: true
        }
    }],
    Pin: {
        type: String,
        required: false,
        trim: true
    },
    avatar:{
        type:Buffer
    }
   
  },
  {
    timestamps: true
})

  userSchema.virtual('tasks', {
    ref: 'Task',
    localField: '_id',
    foreignField: 'owner'
})
// userSchema.virtual('StudentTasks1', {
//     ref: 'Task',
//     localField: '_id',
//     foreignField: 'TeacherName'
// })

  
userSchema.methods.generateAuthToken= async function (){
    const user = this
    const token = jwt.sign({_id:user.id.toString()},"thisismynewcourse")

    user.tokens = user.tokens.concat({token})
    
    await user.save()

    return token

}

userSchema.statics.CheckValidate = async (id,Pin)=>{
const user =await User.find({_id:id, Pin:Pin})
if(!user){


    return false

}
if(!user.Pin == Pin){

    return false

}
return user

}


userSchema.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    delete userObject.password
    delete userObject.tokens
    if(userObject.avatar){
        userObject.avatar=userObject.avatar.toString("base64")
    }

    return userObject
}

userSchema.statics.DeleteFrom = async (Data)=>{
    const user =await User.findOneAndDelete({Data})
      
    
    return user
    
    }


// userSchema.statics.DeleteUser = async (name)=>{
//     const user = await User.findOneAndDelete({name})

        
//     return user 
//      }

userSchema.statics.findUser = async (name, password)=>{
 const user = await User.findOne({name})

 if(!user){
     throw new Error('Unable to login!')
 }
 const isMatch = await bcrypt.compare(password,user.password)
 if(!isMatch){
     throw new Error('Unable to login!')
 }
 return user 
  }
  userSchema.statics.findIfD = async (name)=>{
    const Teacher = require('./teacher')

    const user = await Teacher.findOne({name:name})
    if(user){
        return false
    }
  return true
   
    
    }

//hash the password
  userSchema.pre('save', async function(next){
const user = this
if(user.isModified('password')){
    user.password = await bcrypt.hash(user.password,8)

}
next()
  })
  
  userSchema.pre('remove', async function (next) {
    const user = this
    await Task.deleteMany({ owner: user._id })
    next()
})

const User = mongoose.model('User', userSchema)

module.exports = User