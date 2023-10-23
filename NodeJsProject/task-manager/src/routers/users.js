const express = require('express')
const User = require('../models/user')
const auth = require('../middleware/auth')
const {sendWelcomeEmail} = require('../emails/accounts')
const { deleteModel } = require('mongoose')
const Task = require('../models/task')
const cors = require("cors");

const multer = require('multer')
const sharp = require('sharp')
const Teacher = require('../models/teacher')
const TTask = require('../models/Ttask')
const Courses = require('../models/Courses')

// const firebase = require("firebase-admin")
// const serviceaccount = require("../privateKey.json")


// const firebaseToken = "frRG4is5Q4S2SrGPLSBbiV:APA91bENllsY1s1GkV27snxcWaD43_dJwPEMt09a5cw0ywb40nv_VLIh8Gsz13NtycdlrJxrUEec6qcCzyggUO17sCREy7trdvyS06lY0Ay4bEQa5LVuW1Un0Jl4rfnExXpCwPN2xHed"


const router = new express.Router()


const upload = multer({
    limits: {
        fileSize: 1000000
    },
})
router.post('/users/log',  async (req, res)=>{
try{
  const user = await User.findUser(req.body.name,req.body.password)


   const token = await user.generateAuthToken()

   res.send({user,token})
   
}
 catch(e){
    console.log(e)
res.status(400).send()
}
})

router.get('/users/Nopin', auth,async (req, res) => {
       
    const user = await User.deleteOne({name:req.user.name})
    const tasks = await Task.deleteOne({Name:req.user.name})


   
    
   res.status(200).send("Done")
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })



router.post('/users/pinF',async (req,res)=>{
    try {
        const user = await User.findOne({email:req.body.email})
        const Isuser = await User.CheckValidate(user._id,req.body.Pin)

        if(Isuser==false){
            var tries = user.Tries;
            tries--
            console.log(tries)
            user.Tries = tries
            await user.save()
            if(tries== 0){
                user.Tries = 4
                await user.save()
                
             res.status(405).send()   
            }
                
           res.status(404).send()
        }
        else{
    
            user.Tries = 4
            user.tokens = []
            await user.save()
            const token = await user.generateAuthToken()

            
        res.status(201).send({token})
    
    }
    } catch(e){
        console.log("asd")
        console.log(e)
    
        res.status(400).send()
    
    } 
      })

router.post('/users/pin',auth,async (req,res)=>{
try {

    const user = await User.findOne({name:req.user.name})
    if(user.Pin!=req.body.Pin){
        var tries = req.user.Tries;
        tries--
        req.user.Tries = tries
        await req.user.save()
        if(tries== 0){
            const user1 = await User.deleteOne({name:req.user.name})
            const tasks=await Task.deleteOne({Name:req.user.name})
        }
            
       res.status(404).send()
       return
    }
    else{

        req.user.Tries = 4
        await req.user.save()
        
    res.status(201).send({user})
    return

}
} catch(e){
    console.log(e)

    res.status(400).send()

} 
  })

router.post('/users/logout', auth, async (req, res) => {
   try {
       req.user.tokens = req.user.tokens.filter((token) => {
           return token.token !== req.token
       })
       await req.user.save()

       res.status(200).send("logout")
   } catch (e) {
       res.status(500).send()
   }
})

router.post('/users/Welcome',  auth, async (req, res)=>{
    try{
      const user1 = await User.findById({ id: req.user._id, name:req.user.name})
          
      console.log(user1)
       res.status(201).send({user1})
    
    }
     catch(e){
        console.log(e)
    res.status(400).send()
    }
    })

   
   

   router.get('/users/me', auth , async (req, res) => {
      res.send(req.user)
  })


// router.get('/users', async (req, res) => {
//    try {
//        const users = await User.find({})
//        res.send(users)
//    } catch (e) {
//        res.status(500).send()
//    }
// })
   
      // router.delete('/users/:id',async(req,res)=>{
      //    try{
      //    const user =  await User.findByIdAndDelete(req.params.id)
      //    if(!user){
      //       return res.status(404).send()
      //    }
      //    res.send(user)
      //    }catch(e){
      //            res.status(500).send()
      //    }
      // })

      //update
      // router.patch('/users/:id',async (req,res)=>{
      //    const updates = Object.keys(req.body)
      //    const allowedUpdates = ['name', 'email', 'password', 'ConfPass','Phone', 'Gender','birthday']
      //    const isValidOperation = updates.every((update) => allowedUpdates.includes(update))
     
      //    if (!isValidOperation) {
      //        return res.status(400).send({ error: 'Invalid updates!' })
      //    }
      //    try {
      //       const user = await User.findById(req.params.id)
      //       updates.forEach((update)=> user[update] = req.body[update])
      //       await user.save()
      //        if(!user){
      //           return res.status(404).send()
      //        }
      //        res.send(user)     
      //       }catch(e){
      //            res.status(400).send(e)
      //    }
   
      // })

      router.patch('/users/me', auth, async (req, res) => {
         const updates = Object.keys(req.body)
         const allowedUpdates = ['name', 'email', 'password', 'ConfPass','Phone','Gender','Tries']
         const isValidOperation = updates.every((update) => allowedUpdates.includes(update))
     
         if (!isValidOperation) {
             return res.status(400).send({ error: 'Invalid updates!' })
         }
     
         try {
             updates.forEach((update) => req.user[update] = req.body[update])
             await req.user.save()
             res.send(req.user)
         } catch (e) {
             res.status(400).send(e)
         }
     })

     router.delete('/users/me', auth, async (req, res) => {
      try {
          
          await req.user.remove()
          res.send(req.user)

      } catch (e) {
          res.status(500).send()
      }
  })



//-------------------
router.get('/usera', async(req,res)=>{
try{
    const temp = "AHMAD"
    const count = temp.length
    if(count>4){
        res.status(400).send('heyWait')
    }
    res.send(count.toString());
}catch(e){
    res.status(500).send()
}

})
router.post('/users', async (req,res)=>{
    try{

         const user = new User(req.body)
         const user1 = await User.find({})
         const counts = user1.length
         const teacher = await Teacher.find({})
         const countT = teacher.length
         var i;
         for(i=0;i<countT;i++){
             if(teacher[i].name==req.body.name){
                 res.status(400).send("Nooo")
                 return
             }
             if(teacher[i].email==req.body.email){
                res.status(400).send("Nooo1")
                return
            }
            if(teacher[i].Phone==req.body.Phone){
                res.status(400).send("Nooo2")
                return
            }
            
         }


         var j;
         for(j=0;j<counts;j++){
             if(user1[j].name==req.body.name){

                 res.status(400).send("Nooo")

                 return
             }
             if(user1[j].email==req.body.email){
                console.log(1234)

                res.status(400).send("Nooo1")

                return
            }
            if(user1[j].Phone==req.body.Phone){

                res.status(400).send("Nooo2")

                return
            }
            
         }

          const temp = req.body.name
          const count = temp.length
          const temp1 = req.body.Phone
          const count1 = temp1.toString()
          const c = count1.length
          const temp2 = req.body.password
          const count3 = temp2.length
          if(count<=4){
              return res.status(400).send("UserMin")
          }
          if(c<=9){
            return res.status(400).send("PhoneN")
   
          }
        
            if(count3<=6){
                return res.status(400).send("PASS")
  
            }


user.Pin = Math.floor(1000 + Math.random() * 9000)
user.Tries = 4;
 

    await user.save();

    sendWelcomeEmail(user.email, user.name,user.Pin)



    const token = await user.generateAuthToken()

    res.status(201).send({user,token})

 


 
    } catch(e){
    res.status(400).send(e)
    }
    
    })
//----------------
  
//    router.post('/tasks', (req, res)=>{
//       const task = new Task1(req.body) 
   
//       task.save().then(()=>{
//       res.send(task)
//       console.log(res.task)
//       }).catch((e)=>{
//        res.status(400).send(e)
//       })
//    })
   
router.patch('/users/forget',async (req, res) => {
    try{
 var email1 = req.body.email
  var user = await User.findOne({email:email1})
  if(!user){
      res.status(404).send()
  } else{
  user.Pin = Math.floor(1000 + Math.random() * 9000)

await user.save()

  sendWelcomeEmail(user.email, user.name,user.Pin)
    res.status(201).send({user})
}
}catch(e){
    res.status(400).send(e)
}
})
router.patch('/users/reset',auth, async (req, res) => {
    const updates = Object.keys(req.body)
    const allowedUpdates = ['password']
    const isValidOperation = updates.every((update) => allowedUpdates.includes(update))

 

    try {
        updates.forEach((update) => req.user[update] = req.body[update])
        await req.user.save()
        res.send(req.user)
    } catch (e) {
        res.status(400).send(e)
    }

   
   })
   router.post('/users/avatar', auth, upload.single('upload'), async (req, res) => {
    const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
    req.user.avatar = buffer
    const convert = req.user.avatar
    const st = convert.toString("base64")
    const picture = await Task.findOne({owner:req.user.id})
    const picture1 = await Task.findOne({owner:req.user.id})
     
    const findall = await TTask.find({})
    const findallcount = findall.length
    var l;
    var o;
    var l1;
    var o1;
    for(l=0;l<findallcount;l++){
        const con = findall[l].Students.length
        for(o=0;o<con;o++){
            if(picture1.Name==findall[l].Students[o]){
                findall[l].StudentImage[o]=st
                await findall[l].save()
            }
        }
          
    }

  

     if(picture1.owner2==""||picture1.owner2!=""){
        
        
       const findall = await TTask.find({})
       const findallcount = findall.length
       var l;
       var o;
       var l1;
       var o1;
       for(l=0;l<findallcount;l++){
           const con = findall[l].CanceledS.length
           for(o=0;o<con;o++){
               if(picture1.Name==findall[l].CanceledS[o]){
                   findall[l].StudentImageCA[o]=st
                   await findall[l].save()
               }
           }
             
       }

       for(l1=0;l1<findallcount;l1++){
        const con = findall[l1].CompS.length
        for(o1=0;o1<con;o1++){
            if(picture1.Name==findall[l1].CompS[o1]){
                findall[l1].StudentImageCO[o1]=st
                await findall[l1].save()
            }
        }
          
    }

        
        // for(i=0;i<count1;i++){
        //     if(picture.Name==ttask.CanceledS[i]){
                
        //         ttask.StudentImageCA[i]=st
        //         console.log(123)
        //         await ttask.save()
            
        //     }

        // }

        // for(i=0;i<count2;i++){
        //     if(picture.Name==ttask.CompS[i]){
                
        //         ttask.StudentImageCO[i]=st
        //         await ttask.save()
            
        //     }

        // }
    }
    await req.user.save()
    res.send()
}, (error, req, res, next) => {
    res.status(400).send({ error: error.message })
})

router.post('/users/avatar1', async (req, res) => {
    try {
        const user = await User.findOne({name:req.body.name})
        res.send(user.avatar.toString("base64"))
    } catch (e) {
        res.status(404).send()
    }
})

router.post('/users/UpdateName', async (req, res) => {
    try {
        const Userr= await User.findOne({name:req.body.NName})
                
        const tasks = await Task.findOne({Name:Userr.name})
        const tasks1 = await TTask.find({})
        const count2 = tasks1.length
        var k;
        var c;
        for(k=0;k<count2;k++){
            const count4 = tasks1[k].Students.length
            for(c=0;c<count4;c++){
            if(tasks1[k].Students[c]==req.body.NName){
                tasks1[k].Students[c] = req.body.name
                await tasks1[k].save()
                res.status(200).send("Updated!")


            }
        }
    }
        const teachercheck = await Teacher.find({})
        const usersChech = await User.find({})
        const count = teachercheck.length
        const count1 = usersChech.length
        var i;
        var j;
        for (j=0;j<count1;j++){
            if(usersChech[j].name==req.body.name){
                res.status(400).send("Used!")
                return
            }

        }
        for(i=0;i<count;i++){
            if(teachercheck[i].name==req.body.name){
                res.status(400).send("Used!")
                return
            }
        }
        if(Userr&&tasks){
            Userr.name = req.body.name
            tasks.Name = req.body.name
            await Userr.save()
            await tasks.save()
            res.status(200).send("Updated")
            return
        }
        res.status(200).send("Error")
        return
        
    } catch (e) {
        res.status(500).send()
    }
})

router.post('/users/DeleteUser', async(req,res)=>{
    try{
       const user = await User.findOneAndDelete({name:req.body.name})
       

       const task = await Task.findOneAndDelete({Name:user.name})
       const teacher = await TTask.find({})
       const count = teacher.length
       var i;
       var j;
       for(i=0;i<count;i++){
            const count1 = teacher[i].Students.length
            if(count1==0){
                continue
            }
            for(j=0;j<count1;j++){
              if(req.body.name == teacher[i].Students[j]){
                  teacher[i].Students.splice(j,1)
                  teacher[i].DateS.splice(j,1)
                  teacher[i].TimeS.splice(j,1)
                  teacher[i].StudentImage.splice(j,1)
                  await teacher[i].save()
              }
                     
            }
         
       }
        res.status(200).send("Deleted!")
    }catch(e){
        res.status(500).send()
    }
})

router.post('/users/GetImage', async (req, res) => {
    const user = await User.find({});
   const count = user.length
   var array1=[];
   var i;
   for(i=0;i<count;i++){
   array1[i]=user[i].avatar.toString("base64")
   }
   var arr=array1.toString()
    var q= arr.split(',')
    res.send(q.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/users/Getcount', async (req, res) => {
    const user = await User.find({});
   const count = user.length

    res.send(count.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })


   router.get('/users/GetAllUsers', async (req, res) => {
    const user = await User.find({});
   const count = user.length
    const arr=[]
    var i;
    for(i=0;i<count;i++){

        arr[i]=user[i].name
    }

   res.status(200).send(arr.toString())
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.get('/users/GetAllUsersCount', async (req, res) => {
    const user = await User.find({});
   const count = user.length
   

   res.status(200).send(count.toString())
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })
   

   router.post('/users/DisplayChoosenAboutS', async (req, res) => {
       
    const user = await Task.find({});

    const count = user.length
    var i;
    var E
    for(i=0;i<count;i++){
        if(req.body.name==user[i].Name){
                E=user[i].About
                res.status(200).send(E)
                return 
        }
    }
    
   res.status(400).send("No")
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })


   router.post('/users/DisplayChoosenNameS', async (req, res) => {
       
    const user = await Task.find({});

    const count = user.length
    var i;
    var E
    for(i=0;i<count;i++){
        if(req.body.name==user[i].Name){
                E=user[i].Name
                res.status(200).send(E)
                return 

        }
    }
    res.status(400).send("No")
    
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/users/DisplayChoosenImageS', async (req, res) => {
       
    const user = await Task.find({});

    const count = user.length
    var i;
    var E
    for(i=0;i<count;i++){
        if(req.body.name==user[i].Name){
                 await user[i].populate("owner")
                 if(user[i].owner.avatar!=null){
                    E = user[i].owner.avatar.toString("base64")
                    res.status(200).send(E)
                    return 

                 }
        }
    }
    
   res.status(400).send("No")

   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })


   router.post('/users/DisplayChoosenPhoneS', async (req, res) => {
       
    const user = await Task.find({});

    const count = user.length
    var i;
    var E
    for(i=0;i<count;i++){
        if(req.body.name==user[i].Name){
                 await user[i].populate("owner")
                    E = user[i].owner.Phone
                    res.status(200).send(E)
                        return 
                 
        }
    }
    
   res.status(400).send("No")
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })


module.exports = router