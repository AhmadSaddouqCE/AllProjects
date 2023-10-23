const mongoose = require('mongoose')

const userSchema2 = new mongoose.Schema({ 
 

  
    
  
      name: {
          type: String,
          unique:true,
          required: true,
          trim: true,
          
          
          
      },
      Description: {
          type: String,
          required: true,
          trim: true,
         
          },
          Price:{
              type: String,
              required:true,
              trim:true

          },
          Quantity:{
              type:String,
              required:false,
              trim:true

          },
      
 
  
   
     

      tokens: [{
        token: {
            type: String,
            required: true
        }
    }],
    
    avatar:{
        type:Buffer
    }
   
  },
  {
    timestamps: true
})

 




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




const Instruments = mongoose.model('Instruments', userSchema2)

module.exports = Instruments