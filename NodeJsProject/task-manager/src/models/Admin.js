const mongoose = require('mongoose')
const validator = require('validator')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')
// const TTask = require('./Ttask')

const userSchema2 = new mongoose.Schema({ 
    Phone:{
    type : String,
    unique:true,
    required: false,
    trim: true,
    minlength: 10,
    validate(value){
     if(validator.equals(value,"")){
      throw new Error("Please fill up the number field!")
     }
  
    }
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
          validate(value) {
              if (!validator.isEmail(value)) {
                  throw new Error('Email is invalid')
              }
          }
      },
 
  
      password: {
          type: String,
          required: true,
          minlength: 7,
          trim: true,
          validate(value) {
              if (value.toLowerCase().includes('password')) {
                  throw new Error('Password cannot contain "password"')
              }
          }
      },
   
     

      tokens: [{
        token: {
            type: String,
            required: true
        }
    }],
    
    avatar:{
        type:Buffer
    },
    HelpName:{
        type:Array,
        required:false,
        trim:true
    },
    HelpDescription:{
        type: Array,
        required:false,
        trim:true
    }

   
  },
  {
    timestamps: true
})

 
// userSchema.virtual('StudentTasks1', {
//     ref: 'Task',
//     localField: '_id',
//     foreignField: 'TeacherName'
// })

  
userSchema2.methods.generateAuthToken= async function (){
    const admin = this
    const token = jwt.sign({_id:admin.id.toString()},"thisismynewcourse")

    admin.tokens = admin.tokens.concat({token})
    
    await admin.save()

    return token

}




userSchema2.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    delete userObject.password
    delete userObject.tokens
    if(userObject.avatar){
        userObject.avatar=userObject.avatar.toString("base64")
    }

    return userObject
}



// userSchema.statics.DeleteUser = async (name)=>{
//     const user = await User.findOneAndDelete({name})

        
//     return user 
//      }

userSchema2.statics.findUser1 = async (name, password)=>{
 const Admin1 = await Admin.findOne({name})
 if(!Admin1){
     throw new Error('Unable to login!')
 }
 var isMatch = true
 if(password!=Admin1.password){
     isMatch=false
 }
 if(!isMatch){
     throw new Error('Unable to login!')
 }
 return Admin1 
  }
  


const Admin = mongoose.model('Admin', userSchema2)

module.exports = Admin