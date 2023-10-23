const express = require('express')
const auth1 = require('../middleware/auth1')
const { sendWelcomeEmail} = require('../emails/accounts')
const { deleteModel } = require('mongoose')
const Teacher = require('../models/teacher')
const User = require('../models/user')
const Task = require('../models/task')
const TTask = require('../models/Ttask')
const multer = require('multer')
const sharp = require('sharp')




const router = new express.Router()

const upload = multer({
    limits: {
        fileSize: 1000000
    },
})
// router.post('/users/log',  async (req, res)=>{
// try{
//   const user = await User.findUser(req.body.name,req.body.password)
  
//    const token = await user.generateAuthToken()

//    res.send({user,token})
   
// }
//  catch(e){
//     console.log(e)
// res.status(400).send()
// }
// })



// router.post('/users/pinF',async (req,res)=>{
//     try {
//         const user = await User.findOne({email:req.body.email})
//         const Isuser = await User.CheckValidate(user._id,req.body.Pin)

//         if(Isuser==false){
//             var tries = user.Tries;
//             tries--
//             console.log(tries)
//             user.Tries = tries
//             await user.save()
//             if(tries== 0){
//                 user.Tries = 4
//                 await user.save()
                
//              res.status(405).send()   
//             }
                
//            res.status(404).send()
//         }
//         else{

    
//             user.Tries = 4
//             user.tokens = []
//             await user.save()
//             const token = await user.generateAuthToken()

            
//         res.status(201).send({token})
    
//     }
//     } catch(e){
//         console.log("asd")
//         console.log(e)
    
//         res.status(400).send()
    
//     } 
//       })

// router.post('/users/pin',auth,async (req,res)=>{
// try {

//     const user = await User.CheckValidate(req.user._id,req.body.Pin)
//     if(user==false){
//         var tries = req.user.Tries;
//         tries--
//         req.user.Tries = tries
//         await req.user.save()
//         if(tries== 0){
//             const deleteFromData = await User.DeleteFrom(req.user)
//         }
            
//        res.status(404).send()
//     }
//     else{

//         req.user.Tries = 4
//         await req.user.save()
        
//     res.status(201).send({user})

// }
// } catch(e){
//     console.log(e)

//     res.status(400).send()

// } 
//   })

router.get('/teacher/logout', auth1, async (req, res) => {
   try {
       req.teacher.tokens = req.teacher.tokens.filter((token) => {
           return token.token !== req.token
       })
       await req.teacher.save()

       res.send()
   } catch (e) {
       res.status(500).send()
   }
})

// router.post('/users/Welcome',  auth, async (req, res)=>{
//     try{
//       const user1 = await User.findById({ id: req.user._id, name:req.user.name})
          
//       console.log(user1)
//        res.status(201).send({user1})
    
//     }
//      catch(e){
//         console.log(e)
//     res.status(400).send()
//     }
//     })

   
   

//    router.get('/users/me', auth , async (req, res) => {
//       res.send(req.user)
//   })
//--------------

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

//       router.patch('/users/me', auth, async (req, res) => {
//          const updates = Object.keys(req.body)
//          const allowedUpdates = ['name', 'email', 'password', 'ConfPass','Phone','Gender','Tries']
//          const isValidOperation = updates.every((update) => allowedUpdates.includes(update))
     
//          if (!isValidOperation) {
//              return res.status(400).send({ error: 'Invalid updates!' })
//          }
     
//          try {
//              updates.forEach((update) => req.user[update] = req.body[update])
//              await req.user.save()
//              res.send(req.user)
//          } catch (e) {
//              res.status(400).send(e)
//          }
//      })

//      router.delete('/users/me', auth, async (req, res) => {
//       try {
          
//           await req.user.remove()
//           res.send(req.user)

//       } catch (e) {
//           res.status(500).send()
//       }
//   })



//-------------------
router.post('/teachers',  async (req,res)=>{
    try{
         const teacher = new Teacher(req.body)
         const users= await User.find({})
         const teacher1 = await Teacher.find({})
         const countt = teacher1.length
         const countU = users.length
         var i;
         for(i=0;i<countU;i++){
             if(users[i].name==req.body.name){
                 res.status(400).send("Nooo")
                 return
             }
             if(users[i].email==req.body.email){
                res.status(400).send("Nooo1")
                return
            }
            if(users[i].Phone==req.body.Phone){
                res.status(400).send("Nooo2")
                return
            }
         }
         var j;
         for(j=0;j<countt;j++){
             if(teacher1[j].name==req.body.name){
                 res.status(400).send("Nooo")
                 return
             }
             if(teacher1[j].email==req.body.email){
                res.status(400).send("Nooo1")
                return
            }
            if(teacher1[j].Phone==req.body.Phone){
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
teacher.Pin = Math.floor(1000 + Math.random() * 9000)
teacher.Tries = 4;


    await teacher.save();
    // sendWelcomeEmail(teacher.email, teacher.name,teacher.Pin)
   const token = await teacher.generateAuthToken1()
        
    res.status(201).send({teacher,token})


 


 
    } catch(e){
    res.status(400).send(e)
    }
    
    })
    
router.post('/teachers/log',  async (req, res)=>{
    try{
      const teacher = await Teacher.findUser1(req.body.name,req.body.password)
      
       const token = await teacher.generateAuthToken1()
    
       res.send({teacher,token})
       
    }
     catch(e){
        console.log(e)
    res.status(400).send()
    }
    })
//----------------
router.delete('/tasks/me1', auth1, async (req, res) => {
    try {

        await req.teacher.remove()
        const user = await User.updateMany(
            {
                owner1 : req.teacher._id
            },
            {
                $set : {
                    "owner1" : ""
                }
            },
            {upsert: true},
            (err, doc)=>{
                if(err) console.log(err);
                console.log(doc)
             }

            )
        const task = await Task.updateMany(
            {
                name : user.name
            },
            {
            $set:{
                "instrument" : ""
            }, 
         

                    },
                    {upsert: 
                        true},
                    (err, doc)=>{
                        if(err) console.log(err);
                        console.log(doc)
                     }
 )

        
                  
        await user.save()
        await task.save()
        res.send(req.teacher)
                       


    } catch (e) {
        res.status(500).send()
    }
})
router.post('/teachers/DeleteTeacher', async(req,res)=>{
    try{

             const Teacherid = await Teacher.findOne({name:req.body.name})
             const string = Teacherid._id.toString()
             const usertaskss = await Task.find({})
       const usertask = await Task.find({})
       const count = usertask.length
       var i;
       for(i=0;i<count;i++){
               if(usertaskss[i].owner2==null||usertask[i].owner2==""){
                   continue
               }   
        await usertaskss[i].populate("owner2")
           if(usertask[i].owner2==string){
                   usertask[i].instrument=""
                   usertask[i].Date=""
                   usertask[i].Time=""
                   usertask[i].rating=""
                   usertask[i].owner2=""

                   await usertask[i].save()
                
           }
         

       }

       const userr = await User.find({})
       const userr1 = await User.find({})
       const count5 = userr.length
       var k;
       for(k=0;k<count5;k++){
           if(userr1[k].owner1==null||userr1[k].owner1==""){
                 continue
           }
           await userr1[k].populate("owner1")
             if(userr[k].owner1==string){
                 userr[k].owner1=""
                 await userr[k].save()
             }
       }
       const user = await Teacher.findOneAndDelete({name:req.body.name})
       const task = await TTask.findOneAndDelete({NName:user.name})
        res.status(200).send("Deleted!")
    }catch(e){
        res.status(500).send()
    }
})
  
router.post('/teachers/avatar', auth1, upload.single('upload'), async (req, res) => {
    const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
    req.teacher.avatar = buffer
    await req.teacher.save()
    res.send()
}, (error, req, res, next) => {
    res.status(400).send({ error: error.message })
})

router.post('/teachers/avatar1', async (req, res) => {
    try {
        const teacher = await Teacher.findOne({name:req.body.name})
        res.send(teacher.avatar.toString("base64"))
    } catch (e) {
        res.status(404).send()
    }
})

router.post('/teachers/GetImage', async (req, res) => {
    const teacher = await Teacher.find({});
   const count = teacher.length
   var array1=[];
   var i;
   for(i=0;i<count;i++){
       if(teacher[i].avatar==null||teacher[i].avatar==""){
           array1[i] = ""
           continue
       }
   array1[i]=teacher[i].avatar.toString("base64")
   }
   var arr=array1.toString()
    var q= arr.split(',')
    res.send(q.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/teachers/Getcount', async (req, res) => {
    const teacher = await Teacher.find({});
   const count = teacher.length

    res.send(count.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.get('/teachers/GetAllTeachers', async (req, res) => {
    const user = await Teacher.find({});
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

   router.get('/teachers/GetAllTeachersCount', async (req, res) => {
    const user = await Teacher.find({});
   const count = user.length


   res.status(200).send(count.toString())
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/teachers/reset',auth1, async (req, res) => {
    const user = await Teacher.findOne({name:req.teacher.name});
    if(user){
        user.password=req.body.password

    }
    await user.save()

   res.status(200).send(user)
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })
//    router.post('/tasks', (req, res)=>{
//       const task = new Task1(req.body) 
   
//       task.save().then(()=>{
//       res.send(task)
//       console.log(res.task)
//       }).catch((e)=>{
//        res.status(400).send(e)
//       })
//    })
   
// router.patch('/users/forget',async (req, res) => {
//     try{
//  var email1 = req.body.email
//   var user = await User.findOne({email:email1})
//   if(!user){
//       res.status(404).send()
//   } else{
//   user.Pin = Math.floor(1000 + Math.random() * 9000)

// await user.save()

//   sendWelcomeEmail(user.email, user.name,user.Pin)
//     res.status(201).send({user})
// }
// }catch(e){
//     res.status(400).send(e)
// }
// })
// router.patch('/users/reset',auth, async (req, res) => {
//     const updates = Object.keys(req.body)
//     const allowedUpdates = ['password']
//     const isValidOperation = updates.every((update) => allowedUpdates.includes(update))

 

//     try {
//         updates.forEach((update) => req.user[update] = req.body[update])
//         await req.user.save()
//         res.send(req.user)
//     } catch (e) {
//         res.status(400).send(e)
//     }

   
//    })
module.exports = router