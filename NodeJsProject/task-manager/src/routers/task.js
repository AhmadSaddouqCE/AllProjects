const express = require('express')
const Task = require('../models/task')

const auth = require('../middleware/auth')
const auth1 = require('../middleware/auth1')

const User = require('../models/user')
const Teacher = require('../models/teacher')
const TTask = require('../models/Ttask')
const { translateAliases } = require('../models/task')
const Instruments = require('../models/ShoppingInstruments')

const multer = require('multer')
const sharp = require('sharp')
const { integer } = require('sharp/lib/is')
const { compareSync } = require('bcrypt')
const Admin = require('../models/Admin')


const router = new express.Router()
const upload = multer({
    limits: {
        fileSize: 1000000
    },
})

router.post('/tasks', auth, async (req, res) => {

    const task = new Task({
        ...req.body,
        owner: req.user._id,
        Name : req.user.name
    })

    try {

        task.Education = "Hey, Tell us About Your Qualifications."
        task.About = "Hi, Tell Us About You :)"
       
        await task.save()
        res.status(201).send(task)
    } catch (e) {
        res.status(400).send(e)
    }
})

router.get('/tasks',auth, async (req, res) => {
    try {

        await req.user.populate('tasks')

        res.send(req.user.tasks)
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/tasks/Ed',auth, async (req, res) => {
    try {
        const user1 = await Task.findOne({ owner: req.user.id})
         

          res.status(201).send(user1.Education)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/ABOU',auth, async (req, res) => {
    try {
        const user1 = await Task.findOne({ owner: req.user.id})
         

          res.status(201).send(user1.About)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/SD',auth, async (req, res) => {
    try {
        const user1 = await Task.findOne({ owner: req.user.id})
         

          res.status(200).send(user1.Date)

        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/tasks/ST',auth, async (req, res) => {
    try {
        const user1 = await Task.findOne({ owner: req.user.id})
          
          res.status(200).send(user1.Time)

        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/tasks/STN',auth, async (req, res) => {
    try {
        const user1 = await Task.findOne({ owner: req.user.id})
    await user1.populate('owner2')
res.status(200).send(user1.owner2.name)
        
    } catch (e) {
        res.status(500).send()
    }
})



// router.get('/tasks/count',auth, async (req, res) => {
//     try {
//         const user1 = await TTask.findOne({ NName: req.body.name})

         

//           res.status(201).send(user1.toString())

        
//     } catch (e) {
//         res.status(500).send()
//     }
// })

router.post('/tasks/test',auth,async (req, res) => {


        
    try {

        // const task = await Task.findOne({ owner: req.user._id})
                     

        //        const teacher = await TTask.findOne({NName:req.body.name,instrument: req.body.instrument})
        //            const teacher1 = await Teacher.findOne({name:req.body.name})
        //            if(!teacher1){

        //            }
        //            task.instrument = teacher.instrument
        //            task.TeacherName = teacher1
       
        
    } catch (e) {
        res.status(400).send(e)
    }
})
//----------
router.patch('/tasks/TheTeacher',auth,async (req, res) => {
    const updates = Object.keys(req.body)
    const allowedUpdates = ['instrument','Time']
    const isValidOperation = updates.every((update) => allowedUpdates.includes(update))
    
        
    try {
        const IFHasTeacher = await Task.findOne({Name: req.user.name})
        const COUNT = await TTask.findOne({NName: req.body.name})
          
        const count2 = COUNT.BreakDate.length
        const toString = req.user.avatar
        if(toString==""||toString==null){
            res.status(400).send("DefineYourSelf")
            return
        }
        const t = toString.toString("base64")
        
            var k
            var k1
               for(k=0;k<count2;k++){
                   if(req.body.Date==COUNT.BreakDate[k]){
                            if(req.body.Time==COUNT.BreakTime[k]){
                                   res.status(400).send("BreakTime")
                                   return

                            

                      }

                   }

               }

        if(COUNT.Students.length>0){
            for(var i =0 ; i<COUNT.Students.length;i++){
                if(COUNT.Students[i]==req.user.name){
                    console.log("ThisStudentIsAlreadySigned")
                   return res.status(400).send("AlreadySigned");
    
                }
            }
        }
        if(!IFHasTeacher.Time==""){
            if(!IFHasTeacher.Date==""){
            return res.status(400).send("NO");
                   
        }
        return res.status(400).send("NO");
        
        }
       
        if(COUNT.Students.length>3){

            return res.status(400).send("Max");

        }
       
 
    if(COUNT.DateS.length>0){
        if(COUNT.TimeS.length>0){
        if(COUNT.NName == req.body.name && COUNT.instrument == req.body.instrument){
            for(var i = 0 ;i<COUNT.DateS.length;i++){
             if(COUNT.DateS[i]== req.body.Date){
                 for(var j= 0; j<COUNT.TimeS.length;j++){
                  if(COUNT.TimeS[j] == req.body.Time){
                    return res.status(400).send("BookedDate");

                    }
                  else{
                      continue
                  }    
                 }
             }
            
            }
        }

    }
}


        const task = await Task.findOne({ owner: req.user._id})
               const teacher = await TTask.findOneAndUpdate(
                   {
                       NName:req.body.name,
                       instrument : req.body.instrument

                
            },
            {
                $push: {
               Students : req.user.name,
               TimeS : req.body.Time,
               DateS : req.body.Date,
               StudentImage:t
               
                },
                
            
            
            } 
                )
              
                   

                     

           
        
                   const teacher1 = await Teacher.findOne({name:req.body.name})
                   const user1 = await User.findOne({name:req.user.name})
                   if(!teacher){
                       throw new Error()
                   }
                   task.instrument = teacher.instrument
                   task.Time = req.body.Time
                   task.Date = req.body.Date
                   user1.owner1 = teacher1.id
                   task.owner2= teacher1.id

                   console.log(user1.owner1)




       
        updates.forEach((update) => task[update] = req.body[update],
        
        
        )
            
        task.Status = "Upcoming"
        
        await task.save()
        await teacher.save()
        await user1.save()


        await req.user.save()
        res.send(teacher.Students)
        
    } catch (e) {
        res.status(400).send(e)
    }
})
//------

router.get('/tasks/name',auth, async (req, res) => {
    try {
        const user = await User.findOne({ _id: req.user.id})
         

          res.status(201).send(req.user.name)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/About',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
         

          res.status(201).send(user.About)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/Education',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
         

          res.status(201).send(user.Education)

        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/tasks/Sinstrument',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
         

          res.status(201).send(user.instrument)

        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/tasks/email',auth, async (req, res) => {
    try {
        const user = await User.findOne({ _id: req.user.id})
         
          res.status(201).send(req.user.email)
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/Time',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
         
          res.status(201).send(user.Time)
        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/tasks/Ins',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
         
          res.status(201).send(user.instrument)
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/TS',auth, async (req, res) => {
    try {
  
        const task = await User.findOne({name:req.user.name})

        await task.populate('owner1')
            
        console.log(task.owner1)
          res.status(201).send(task.owner1.name)
        
    } catch (e) {
        res.status(500).send()
    }
})

router.post('/tasks/SaveRating',auth, async (req, res) => {
    try {
        const userTask = await User.findOne({name:req.body.Name})
        const StudentsTeacher = await Task.findOne({Name:req.body.Name})
        if(StudentsTeacher.owner2==""||StudentsTeacher.owner2==null){
            res.status(400).send("YouCant")
        }
        await StudentsTeacher.populate('owner2')
        const StudentsTeacher1 = await Teacher.findOne({name:req.body.name})

        if(StudentsTeacher.owner2._id.toString()!=StudentsTeacher1._id.toString()){
            res.status(400).send("YouCant")
        }
        else{
        const Taskk = await Task.findOne({owner:userTask._id})
             await userTask.populate('owner1')


        Taskk.rating = req.body.rating

        const FindTheStudent = await TTask.findOne({NName:userTask.owner1.name})
        const count = FindTheStudent.Students.length
        const count1 = FindTheStudent.ratingAvg.length
        var Temp;
        var i;

        for(i=0;i<count;i++){
            if(FindTheStudent.Students[i]==req.body.Name){
                Temp=i;
                break;
            }
          
        }
        if(Temp==-1){
            FindTheStudent.ratings.splice(FindTheStudent.Students.length-1, 0, Taskk.rating);
            FindTheStudent.ratingAvg.splice(FindTheStudent.Students.length-1, 0, Taskk.rating);
  
            
               
    }
    else if(Temp>=0){
        
         
          FindTheStudent.ratings.splice(Temp,1,Taskk.rating)
          FindTheStudent.ratingAvg.splice(Temp, 1, Taskk.rating);
                   
            await Taskk.save()
            await FindTheStudent.save()
          res.status(200).send(FindTheStudent.NName)
    }
}
        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/tasks/short',auth, async (req, res) => {
    try {
        const user = await User.findOne({ _id: req.user.id})
        var email= req.user.name
        var e = email.toUpperCase().split('')
          res.status(201).send(e[0]+e[1])
          
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/StudebtsInstruments',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
        var ins= user.instrument
    
          res.status(200).send(ins)
          
        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/tasks/TeachersImage',auth, async (req, res) => {
    try {
        const user = await Task.findOne({ owner: req.user.id})
        
        await user.populate("owner2")
        const name = user.owner2.avatar
        const to = name.toString('base64')
      
          res.status(200).send(to)
          
        
    } catch (e) {
        res.status(500).send()
    }
})

router.post('/tasks/data', auth ,async (req, res) => {
    try {
        const user = await Task.findOne({owner:req.user.id})
        const Shop = await Instruments.find({})
        const count = Shop.length
        const count1 = user.CartName.length
        var j;
          
        var i;
        var temp=0;
        const CartQuantity1=0;

          
        for(i=0;i<count;i++){
             if(Shop[i].name==req.body.CartName){
                 
                temp=i;
             }

        }
          var n1="";
          var n2="";
          var n3=0;
          var n4=0;
          var n5;

       if(req.body.CartQuantity==0){
            res.status(400).send("NO")
        }
        var check = parseInt(Shop[temp].Quantity) - parseInt(req.body.CartQuantity)

        if(check<0){
           
           res.status(400).send("Over")
           return
        }
      if(parseInt(Shop[temp].Quantity)<parseInt(req.body.CartQuantity)){
  
          res.status(400).send("Over")
          return
      }
// var n6=0;
var n7=0;
            
           for(j=0;j<count1;j++){
            if(req.body.CartName==user.CartName[j]){
               n1=parseInt(user.CartQuantity[j])
               n2=parseInt(req.body.CartQuantity)
               n5=parseInt(Shop[temp].Price)
               n3= n1+n2
            //    n6 = (n2*n5)+n7
               user.CartQuantity[j]=n3.toString()
            //    user.CartPrice[j]=n6.toString()
              Shop[temp].Quantity-=req.body.CartQuantity
              console.log(Shop[temp].Quantity);
              await Shop[temp].save()
              await user.save()
             res.status(200).send("true")

             return


            }
            
            
          }


          if(Shop[temp].Quantity==0){
            res.status(400).send("Over1")
            return
   
           }
   

        


           else{

            const PushData = await Task.findOneAndUpdate({owner:req.user.id},

                {
                    $push:{
                        CartPrice:req.body.CartPrice,
                        CartName:req.body.CartName,
                        CartQuantity:req.body.CartQuantity,
                        CartImage:req.body.CartImage
                    }
                }
            
            
            )
            var q;
            var tmp;

            for(q=0;q<count1;q++){
                if(req.body.CartName==user.CartName[q]){
                    tmp=q
                }
            }
            Shop[temp].Quantity-=req.body.CartQuantity
            n2=parseInt(req.body.CartQuantity)
            n5=parseInt(Shop[temp].Price)
            n7=parseInt(user.CartPrice[tmp])
            n3= n1+n2
            // n6 = (n2*n5)+n7
            // user.CartPrice[tmp]=n6.toString()
            await user.save()
            await Shop[temp].save()
            await PushData.save()
            console.log(Shop[temp].Quantity)
            res.status(200).send("Sent")
            return



        
            }

        
    } catch (e) {

        res.status(400).send()
        return

    }
})
router.patch('/tasks/me', auth, async (req, res) => {
    
    const updates = Object.keys(req.body)
    const allowedUpdates = ['name','About','Education']
    const isValidOperation = updates.every((update) => allowedUpdates.includes(update))
    
        
    try {
        const Task1 = await User.findIfD(req.body.name)

        const task = await Task.findOne({ owner: req.user._id})

        if(Task1==false){
            throw new Error()
           
          }

        updates.forEach((update) => req.user[update] = req.body[update],
        
        )
        updates.forEach((update) => task[update] = req.body[update],
        
        )
        task.Name=req.body.name
        await task.save()

        await req.user.save()
        res.send(task)
        
    } catch (e) {
        res.status(400).send(e)
    }
})

router.get('/tasks/getPrice',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner: req.user.id})
        var arrayPrice=[];
        var i;
        for(i=0;i<user.CartPrice.length;i++){
            arrayPrice[i]=user.CartPrice[i]
        }

        res.status(200).send(arrayPrice.toString())
        
    } catch (e) {
        res.status(500).send()
    }
})



router.get('/tasks/getQuantity',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner: req.user.id})
        var arrayQuantity=[];
        var i;
        for(i=0;i<user.CartQuantity.length;i++){
            arrayQuantity[i]=user.CartQuantity[i]
        }

        res.status(200).send(arrayQuantity.toString())
        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/tasks/getImage12', auth ,async (req, res) => {
    try {
        const user = await Task.findOne({owner: req.user.id})
       
        var arrayImage=[];
        var i;
        for(i=0;i<user.CartImage.length;i++){
            arrayImage[i]=user.CartImage[i]
        }
        res.status(200).send(arrayImage.toString())


    } catch (e) {
        res.status(500).send()
    }
})
router.get('/tasks/getName',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner: req.user.id})
        var arrayName=[];
        var i;
        for(i=0;i<user.CartName.length;i++){
            arrayName[i]=user.CartName[i]
        }

        res.status(200).send(arrayName.toString())
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/getCount',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner: req.user.id})
            const count = user.CartName.length
       

        res.status(200).send(count.toString())
        
    } catch (e) {
        res.status(500).send()
    }
})


router.post('/tasks/DeleteAp',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner:req.user.id})
        const user1 = await Task.findOne({ owner: req.user.id})
        const user2 = await Task.findOne({owner:req.user.id})
        await user2.populate('owner')
        await user1.populate('owner2')
        
        const teacher = await TTask.findOne({NName:user1.owner2.name})
        const Push = await TTask.findOneAndUpdate({NName:user1.owner2.name},
            
            {
              $push:{
                  ratingAvg:user2.rating
              }

            })
               await Push.save()
        user.Date="";
        user.Time="";
        user.instrument="";
        user.owner2="";
        user2.owner.owner1="";
        var i;
        var temp = 0;
        for(i=0;i<teacher.Students.length;i++){
            if(teacher.Students[i]==user.Name){
             temp = i;
            }
        }
        teacher.DateS.splice(temp,1)
        teacher.Students.splice(temp,1)
        teacher.TimeS.splice(temp,1)
        teacher.StudentImage.splice(temp,1)
        teacher.ratings.splice(temp,1)


        await user.save()
        await teacher.save() 
        await user2.save()
    res.status(200).send([user,teacher,user2])
   
    } catch (e) {
        res.status(500).send()
    }
})

router.post('/tasks/RemoveCart',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner: req.user.id})
        const count = user.CartName.length
        var index1 = await user.CartName.indexOf(req.body.CartName)
        const instru = await Instruments.findOne({name:req.body.CartName})
        console.log(instru.name)

        var j1;
        var j2;
        var j3;
        var inc=0;
        var inc1=0;
     
        for(j1=0;j1<count;j1++){
             if(instru.name==user.CartName[j1]){
                 inc = parseInt(user.CartQuantity[j1])
                 inc1=parseInt(instru.Quantity)
                 inc1+=inc
                instru.Quantity=inc1.toString()
                await instru.save()

       
                }

            
         

        }
        user.CartName.splice(index1,1)
        user.CartPrice.splice(index1,1)
        user.CartImage.splice(index1,1)
        user.CartQuantity.splice(index1,1)
        await user.save()

        res.status(200).send(user)
    } catch (e) {
        res.status(500).send()
    }
})

router.post('/tasks/EditAp',auth, async (req, res) => {
    try {
        const user = await Task.findOne({owner:req.user.id})
        const user1 = await Task.findOne({ owner: req.user.id})
        const user2 = await Task.findOne({owner:req.user.id})
        await user2.populate('owner')
        await user1.populate('owner2')

        const teacher = await TTask.findOne({NName:user1.owner2.name})
        const Push = await TTask.findOneAndUpdate({NName:user1.owner2.name},
            
            {
              $push:{
                  ratingAvg:user2.rating
              }

            })
               await Push.save()
        user.Date="";
        user.Time="";
        user.instrument="";
        user.owner2="";
        user2.owner.owner1="";
        var i;
        var temp = 0;
        for(i=0;i<teacher.Students.length;i++){
            if(teacher.Students[i]==user.Name){
             temp = i;
            }
        }
        teacher.DateS.splice(temp,1)
        teacher.Students.splice(temp,1)
        teacher.TimeS.splice(temp,1)
        teacher.StudentImage.splice(temp,1)
        teacher.ratings.splice(temp,1)

        await user.save()
        await teacher.save() 
        await user2.save()
    res.status(200).send([user,teacher,user2])
   
    } catch (e) {
        res.status(500).send()
    }
})

router.post('/tasks/CartDone',auth, async (req, res) => {
    try {
       const user = await Task.findOne({owner:req.user.id})
           var arr = req.body.CartName.toString()
           var Array = arr.split(",")
           var arr1=req.body.CartDoneQuantity
           console.log(arr1)
           var Array1=arr1.split(",")
           var arr2=req.body.CartDonePrice
           var Array2=arr2.split(",")
           var arr3=req.body.CartDoneImage
           var Array3=arr3.split(",")
           var i;
           var j;
          
           user.CartName.splice(0)
           user.CartImage.splice(0)
           user.CartPrice.splice(0)
           user.CartQuantity.splice(0)
           for(j=0;j<Array.length;j++){
               const task = await Task.findOneAndUpdate({owner:req.user.id
            
            },
            {
                $push:{
                    CartOwns:Array[j],
                    CartDoneQuantity:Array1[j],
                    CartDonePrice:Array2[j],
                    CartDoneImage:Array3[j]
                }
            }
                )
                if(j==Array.length-1){
                    await user.save()
                    await task.save()

                }
            }
           

    res.status(200).send(user)
   
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/tasks/StudentsCount', async (req, res)=>{
try{
const user = await Task.find({})
const count = user.length
res.status(200).send(count.toString())
}catch(e){
    res.status(400).send(e)
}

})

router.get('/tasks/Names', async (req, res) => {
    try {
        const user = await Task.find({})
   
        // await user2.populate('owner')
        var array=[]
        var count = user.length
        var i;
        for(i=0;i<count;i++){
            array[i]=user[i].Name
        }
        res.status(200).send(array.toString())

    } catch (e) {
        res.status(500).send()
    }
})

router.get('/tasks/StudentInstrument', async (req, res) => {
    try {
        const user = await Task.find({})
   
        // await user2.populate('owner')
        var array=[]
        var count = user.length
        var i;
        for(i=0;i<count;i++){
            array[i]=user[i].instrument
        }
        res.status(200).send(array.toString())

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/StudentRatring', async (req, res) => {
    try {
        const user = await Task.find({})
   
        // await user2.populate('owner')
        var array=[]
        var count = user.length
        var i;
        for(i=0;i<count;i++){
            if(user[i].rating == null){
                array[i]=0;
                continue
            }
            array[i]=user[i].rating
        }
        res.status(200).send(array.toString())

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/StudentEmail', async (req, res) => {
    try {
        const user = await Task.find({})
       const user1 = await Task.find({})
        var array=[]
        var count = user1.length
      

        var i;
        for(i=0;i<count;i++){
           
            await user[i].populate('owner')

            array[i]=user[i].owner.email

        }
        res.status(200).send(array.toString())

    } catch (e) {
        res.status(500).send()
    }

    
})



router.get('/tasks/StudentCartDoneCount', auth,async (req, res) => {
    try {
        const carts=await Task.findOne({owner:req.user.id})
        const count = carts.CartOwns.length
        res.status(200).send(count.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.get('/tasks/StudentCartDonePrice', auth,async (req, res) => {
    try {
        const carts=await Task.findOne({owner:req.user.id})
        const count = carts.CartOwns.length
        const array=[]
        var i;
        for(i=0;i<count;i++){
            array[i]=carts.CartDonePrice[i].toString()
        }
        res.status(200).send(array.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/StudentCartDoneImage', auth,async (req, res) => {
    try {
        const carts=await Task.findOne({owner:req.user.id})
        const count = carts.CartOwns.length
        const array=[]
        var i;
        for(i=0;i<count;i++){
            array[i]=carts.CartDoneImage[i].toString()
        }
        res.status(200).send(array.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.get('/tasks/StudentCartDoneQuantity', auth,async (req, res) => {
    try {
        const carts=await Task.findOne({owner:req.user.id})
        const count = carts.CartOwns.length
        const array=[]
        var i;
        for(i=0;i<count;i++){
            array[i]=carts.CartDoneQuantity[i].toString()
        }
        res.status(200).send(array.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.get('/tasks/StudentCartDoneName', auth,async (req, res) => {
    try {
        const carts=await Task.findOne({owner:req.user.id})
        const count = carts.CartOwns.length
        const array=[]
        var i;
        for(i=0;i<count;i++){
            array[i]=carts.CartOwns[i].toString()
        }
        res.status(200).send(array.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.post('/tasks/SendMyProblem', auth, async (req, res) => {
    try {
      const tasks = await Task.findOne({owner:req.user.id})
      const Admins = await Admin.find({})
      const CountOfAdmins = Admins.length
      var i;
      if(tasks){
       for(i=0;i<CountOfAdmins;i++){
           const Adminn = Admins[i].name
           if(Adminn){

               const Adminnn = await Admin.findOneAndUpdate(
                   {
                       name:Adminn
                
                
                    },
                
                {
                    $push:{
                        HelpName: tasks.Name,
                        HelpDescription: req.body.Message
                    }

                }
                )
                await Adminnn.save() 

           }
       } 

      }   
     res.status(200).send("Updated")
    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/HelpArrayCount', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
        const count = helps.HelpResponced.length

      
        res.status(200).send(count.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/HelpArrayCount', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
        const count = helps.HelpResponced.length
 
      
        res.status(200).send(count.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/getToggle', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
            
        res.status(200).send(helps.toggle)
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/getToggleM', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
            
        res.status(200).send(helps.toggleM)
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.post('/tasks/RemoveContact', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
            var count = helps.HelpResponced.length
            var i;
            for(i=0;i<count;i++){
                if(req.body.Message==helps.HelpResponced[i]){
                    helps.HelpResponced.splice(i,1)
                }
            }
            await helps.save()
        res.status(200).send(helps)
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.post('/tasks/RemoveOneCart', auth,async (req, res) => {
    try {
        const carts=await Task.findOne({owner:req.user.id})
        const count = carts.CartOwns.length
        var i;
        for(i=0;i<count;i++){
            if(req.body.name==carts.CartOwns[i]){
                carts.CartOwns.splice(i,1)
            }
        }
        await carts.save() 
        res.status(200).send(carts)
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/getToggleS', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
            helps.toggle="0"
            await helps.save()
        res.status(200).send(helps.toggleS)
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.get('/tasks/ToggleVarible', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
                helps.toggle="0"
                await helps.save()
        res.status(200).send(helps)
       

    } catch (e) {
        res.status(500).send()
    }

    
})

router.get('/tasks/ToggleVaribleM', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
                helps.toggleM="0"
                await helps.save()
        res.status(200).send(helps)
       

    } catch (e) {
        res.status(500).send()
    }

    
})
router.get('/tasks/ToggleVaribleS', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
                helps.toggleS="0"
                await helps.save()
        res.status(200).send(helps)
       

    } catch (e) {
        res.status(500).send()
    }

    
})


router.get('/tasks/HelpArray', auth,async (req, res) => {
    try {
        const helps=await Task.findOne({owner:req.user.id})
        const count = helps.HelpResponced.length
         var array=[]
         var i;
         for(i=0;i<count;i++){
             array[i]=helps.HelpResponced[i]
         }
      
        res.status(200).send(array.toString())
       

    } catch (e) {
        res.status(500).send()
    }

    
})
module.exports = router