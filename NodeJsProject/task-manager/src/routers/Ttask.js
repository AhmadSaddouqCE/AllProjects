const express = require('express')
const TTask = require('../models/Ttask')
const auth1 = require('../middleware/auth1')
const Teacher = require('../models/teacher')
const Task = require('../models/task')
const { count } = require('../models/task')
const User = require('../models/user')
const Courses = require('../models/Courses')
// const { translateAliases } = require('../models/teacher')
const router = new express.Router()


router.post('/taskss', auth1, async (req, res) => {
    const task = new TTask({
        ...req.body,
        owner: req.teacher._id,
        NName: req.teacher.name
        

    })

    try {
        task.Education = "Hey, Tell us About Your Qualifications."
        task.About = "Hi, Tell Us About You :)"
                task.instrument = req.body.instrument

        await task.save()
        res.status(201).send(task)
    } catch (e) {

        res.status(400).send(e)
    }
})

router.get('/Ttasks',auth1, async (req, res) => {
    try {
        await req.teacher.populate('taskss')
        res.send(req.teacher.Ttasks)
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/Ed',auth1, async (req, res) => {
    try {
        const user1 = await TTask.findOne({ owner: req.teacher.id})
         

          res.status(201).send(user1.Education)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/Tinstrument',auth1, async (req, res) => {
    try {
        const user1 = await TTask.findOne({ owner: req.teacher.id})
         

          res.status(201).send(user1.instrument)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/ABOU',auth1, async (req, res) => {
    try {
        const user1 = await TTask.findOne({ owner: req.teacher.id})
         

          res.status(201).send(user1.About)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/name',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})

          res.status(201).send(req.teacher.name)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/About',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})

          res.status(201).send(teacher.About)

        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/Education',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})

          res.status(201).send(teacher.Education)

        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/Ttasks/email',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
         
          res.status(201).send(req.teacher.email)
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/short',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
        var email= req.teacher.name
        var e = email.toUpperCase().split('')
          res.status(201).send(e[0]+e[1])
          
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/STATUSTT',auth1, async (req, res) => {
    try {
        var Temp = [];
        const teacher = await TTask.findOne({owner: req.teacher.id})
        var Students3 = teacher.STUSTATUS
        
           
        res.status(201).send(Students3.toString())

           
          
        
    } catch (e) {
        res.status(500).send()
    }
})
router.post('/Ttasks/GetAbout', async(req, res)=>{

    try{
       const about = await TTask.findOne({NName:req.body.NName})
       res.status(200).send(about.About)


    }catch(e){
        res.status(500).send(e)
    }
})

router.post('/Ttasks/CANCEL',auth1, async (req, res) => {
    try {
        const count = await TTask.findOne({owner:req.teacher.id})
         var ccc = count.Students.length
        const teacher = await TTask.findOne({ owner: req.teacher.id})
        const user = await User.findOne({ owner1: req.teacher.id})
          
        const Dateee= await Task.findOne({Name:req.body.Name})
        const dat = Dateee.Date
        const Timee = Dateee.Time
        var TempJ;
        for(var j=0;j<ccc;j++){
            if(req.body.Name==teacher.Students[j]){
                      
               TempJ=j;
               break;
            }
        }
        if(Dateee.rating){
        const cancelt = await TTask.findOneAndUpdate({owner:req.teacher._id},
            {
                $push:{
                    CanceledS:req.body.Name,
                    ratingAvgCC:Dateee.rating,
                    CanceledSD:req.body.CanceledSD,
                    CanceledST:req.body.CanceledST,
                    CanceledSInstrument:req.body.CanceledSInstrument,
                    StudentImageCA:req.body.StudentImageCA
                
                }
            }
            )
            cancelt.DateS.splice(TempJ,1)
            cancelt.TimeS.splice(TempJ,1)
            cancelt.ratings.splice(TempJ,1)           
            cancelt.ratingAvg.splice(TempJ,1)
            cancelt.Students.splice(TempJ,1)
            cancelt.StudentImage.splice(TempJ,1)
    
           
            
       
             Dateee.Date = "";
             Dateee.Time = "";
             Dateee.instrument = "";
             Dateee.rating=""
             user.owner1 = "";
             Dateee.owner2="";
             Dateee.toggleS="1"
             await user.save()
          await Dateee.save()
         await teacher.save()
          await cancelt.save()  
          
          res.status(200).send(cancelt)
                 
        }
        else{
            const cancelt = await TTask.findOneAndUpdate({owner:req.teacher._id},
                {
                    $push:{
                        CanceledS:req.body.Name,
                        CanceledSD:req.body.CanceledSD,
                        CanceledST:req.body.CanceledST,
                        CanceledSInstrument:req.body.CanceledSInstrument,
                        StudentImageCA:req.body.StudentImageCA
                    
                    }
                }
                )
        cancelt.DateS.splice(TempJ,1)
        cancelt.TimeS.splice(TempJ,1)
        cancelt.ratings.splice(TempJ,1)
        
        cancelt.Students.splice(TempJ,1)
        cancelt.StudentImage.splice(TempJ,1)

       
        
   
         Dateee.Date = "";
         Dateee.Time = "";
         Dateee.instrument = "";
         Dateee.rating=""
         user.owner1 = "";
         Dateee.owner2="";
         Dateee.toggleS="1"
         await user.save()
      await Dateee.save()
     await teacher.save()
      await cancelt.save()
      res.status(200).send(cancelt)

        }
      res.status(200).send(cancelt)
          
        
    } catch (e) {
        res.status(500).send()
    }
})
//
router.get('/Ttasks/CanceledDate',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CanceledSD
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.CanceledSD[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/CanceledTime',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CanceledST
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.CanceledST[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})
//
router.get('/Ttasks/CanceledInstruments',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CanceledSInstrument
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.CanceledSInstrument[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/CanceledImages',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.StudentImageCA
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.StudentImageCA[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})

router.post('/Ttasks/BookSuccess',auth1, async (req, res) => {
    try {

      const teacher = await TTask.findOneAndUpdate(
        {
            owner: req.teacher.id

     
 },
 {
     $pull: {
    Students : req.body.Students,
    TimeS : req.body.TimeS,
    DateS : req.body.DateS
    
     },
     
 
 
 } 
     )
     const teacher1 = await Task.findOneAndUpdate(
        {
            Time: req.body.Time,
            Date : req.body.Date

     
 },
 {
     $pull: {
    Time : req.body.Time,
    Date : req.body.Date,
    
     },
     
 
 
 } 
     )
     await teacher1.save()
     await teacher.save()
     res.status(200).send(teacher)
          
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/ImageN',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({owner: req.teacher.id})

        var Students1 = teacher.StudentImage
        
    res.status(201).send(Students1.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/Ttasks/ListN',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
        var Students1 = teacher.Students
        
    res.status(201).send(Students1.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/ListD',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
 
        var Students3 = teacher.DateS

    res.status(201).send(Students3.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/ListS',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
        var Students2 = teacher.TimeS

    res.status(201).send(Students2.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/count', async (req, res) => {
    try {
        const teacher = await Teacher.find({})
        const count = teacher.length
                        
           res.send(count.toString())
        res.status(201)
        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/count1', async (req, res) => {
    try {
        const teacher = await Teacher.findOne({name : "ABOTALAL1"})
                        
        //    res.send(teacher.toString())
        res.status(201).send(teacher)
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/TeachersList', async (req, res) => {
    try {
        var Temp = [];
        const teacher = await Teacher.find()
        const teacher1 = await Teacher.count()
        for(var i =0;i<teacher1;i++){
                Temp[i]=teacher[i].name


        }
           


        res.status(200).send(Temp.toString())

           
        
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/CCS',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CanceledS
        var countt = test.length
if(countt==1){
        var Temp = [];
      
    
         
        for(var i =0;i<countt;i++){
                Temp[i]=test[i]


        }
    


        res.status(200).send(Temp.toString())
    }
    else if(countt>1){
        var Temp = [];
      
      
        // var split1 = test.split(",")
        //  var count1 = split1.length
         
        for(var i =0;i<countt;i++){
                Temp[i]=test[i]


        }
    }
    res.status(200).send(Temp.toString())

           
}
        
     catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/ALL',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})


    res.status(200).send(teacher)
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})



router.get('/Ttasks/COUNTSC',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
       const Count = teacher.CanceledS.length
       
    res.status(200).send(Count.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})


router.get('/Ttasks/INST', async (req, res) => {
    try {
  
        var Temp = [];
        const teacher = await TTask.find()
        const teacher1 = await TTask.count()
        for(var i =0;i<teacher1;i++){
               
            Temp[i]=teacher[i].instrument


        }
           


        res.status(200).send(Temp.toString())

           
        
        
    } catch (e) {
        res.status(500).send()
    }
})

router.patch('/Ttasks/me', auth1, async (req, res) => {
    
    const updates = Object.keys(req.body)
    const allowedUpdates = ['name','About','Education']
    const isValidOperation = updates.every((update) => allowedUpdates.includes(update))

        
    try {
       

        const task = await TTask.findOne({ owner: req.teacher._id})
      
        const Task1 = await Teacher.findIfD(req.body.name)
        if(Task1==false){
            throw new Error()
           
          }

        updates.forEach((update) => req.teacher[update] = req.body[update],
        
        )
        updates.forEach((update) => task[update] = req.body[update],
        
        )
        task.NName=req.body.name
        await task.save()

        await req.teacher.save()
        res.send(task)
        
    } catch (e) {
        res.status(400).send(e)
    }
})



// router.get('/tasks/:id',auth, async (req, res) => {
//     const _id = req.params.id

//     try {
//         const task = await Task.findOne({ _id, owner: req.user._id })

//         if (!task) {
//             return res.status(404).send()
//         }

//         res.send(task)
//     } catch (e) {
//         res.status(500).send()
//     }
// })

// router.patch('/tasks/:id', auth, async (req, res) => {
//     const updates = Object.keys(req.body)
//     const allowedUpdates = ['description', 'completed']
//     const isValidOperation = updates.every((update) => allowedUpdates.includes(update))

//     if (!isValidOperation) {
//         return res.status(400).send({ error: 'Invalid updates!' })
//     }

//     try {
//         const task = await Task.findOne({ _id: req.params.id, owner: req.user._id})

//         if (!task) {
//             return res.status(404).send()
//         }

//         updates.forEach((update) => task[update] = req.body[update])
//         await task.save()
//         res.send(task)
//     } catch (e) {
//         res.status(400).send(e)
//     }
// })

// router.delete('/tasks/:id', auth, async (req, res) => {
//     try {
//         const task = await Task.findOneAndDelete({ _id: req.params.id, owner: req.user._id })

//         if (!task) {
//             res.status(404).send()
//         }

//         res.send(task)
//     } catch (e) {
//         res.status(500).send()
//     }
// })

router.get('/Ttasks/short',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
        var email= req.teacher.name
        var e = email.toUpperCase().split('')
          res.status(201).send(e[0]+e[1])
          
        
    } catch (e) {
        res.status(500).send()
    }
})



router.post('/Ttasks/COMPS',auth1, async (req, res) => {
    try {
        const count = await TTask.findOne({owner:req.teacher.id})
         var ccc = count.Students.length
        const teacher = await TTask.findOne({ owner: req.teacher.id})
        const user = await User.findOne({ owner1: req.teacher.id})
          
        const Dateee= await Task.findOne({Name:req.body.Name})
        var TempJ;
        for(var j=0;j<ccc;j++){
            if(req.body.Name==teacher.Students[j]){
                      
               TempJ=j;
               break;
            }
        }
        console.log(TempJ);
        const cancelt = await TTask.findOneAndUpdate({owner:req.teacher._id},
            {
                $push:{
                    CompS:req.body.Name,
                    CompSD:req.body.CompSD,
                    CompST:req.body.CompST,
                    ratingAvgCC:Dateee.rating,
                    CompSinstrument:req.body.CompSinstrument,
                    StudentImageCO:req.body.StudentImageCO
                    
                }
            }
            
            )
            
        cancelt.DateS.splice(TempJ,1)
        cancelt.TimeS.splice(TempJ,1)
        cancelt.ratings.splice(TempJ,1)
        cancelt.ratingAvg.splice(TempJ,1)
        cancelt.Students.splice(TempJ,1)
        cancelt.StudentImage.splice(TempJ,1)
    
   
         Dateee.Date = "";
         Dateee.Time = "";
         Dateee.instrument = "";
         Dateee.rating="";
         user.owner1 = "";
         Dateee.owner2="";
         await user.save()
      await Dateee.save()
     await teacher.save()
      await cancelt.save()
      res.status(200).send(cancelt)
          
        
    } catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/CompletedImages',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.StudentImageCO
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.StudentImageCO[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/CompletedDates',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CompSD
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.CompSD[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/CompletedTimes',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CompST
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.CompST[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/CompletedInstruments',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CompSinstrument
        const count = test.length
         var arr=[]
            
         var i;
         for(i=0;i<count;i++){
             arr[i]=teacher1.CompSinstrument[i]
         }

   
    res.status(200).send(arr.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/CCSS',auth1, async (req, res) => {
    try {
        const teacher1 = await TTask.findOne({owner: req.teacher.id})
        var test = teacher1.CompS
        var countt = test.length
if(countt==1){
        var Temp = [];
      
    
         
        for(var i =0;i<countt;i++){
                Temp[i]=test[i]


        }
    


        res.status(200).send(Temp.toString())
        return 
    }
    else if(countt>1){
        var Temp = [];

         
        for(var i =0;i<countt;i++){
                Temp[i]=test[i]


        }
    }
    res.status(200).send(Temp.toString())
          return 
           
}
        
     catch (e) {
        res.status(500).send()
    }
})

router.get('/Ttasks/COUNTSCC',auth1, async (req, res) => {
    try {
        const teacher = await TTask.findOne({ owner: req.teacher.id})
       const Count = teacher.CompS.length
       
    res.status(200).send(Count.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})
router.get('/Ttasks/CountAvg',async (req, res) => {
    try {

        const teacher = await TTask.find()
        var i;
        var j;
        var k;
        var array=0
        var array1=[];
        var sum3=0;
        for(i=0;i<teacher.length;i++){
            if(teacher[i].ratingAvg.length==0){
                if(teacher[i].ratingAvgCC.length==0){
                }

            }
            
            array1[i]=0

           
        }
    
        for(i=0;i<teacher.length;i++){
            if(teacher[i].ratingAvg.length!=0){
                if(teacher[i].ratingAvgCC==0){
                    for(j=0;j<teacher[i].ratingAvg.length;j++){
                     array+=teacher[i].ratingAvg[j] 
                    }
                        array1[i]=array
                        array=0;
                    
                }
                else if(teacher[i].ratingAvgCC.length!=0){
                    if(teacher[i].ratingAvg.length>teacher[i].ratingAvgCC.length){
                        for(k=0;k<teacher[i].ratingAvg.length;k++){
                            if(teacher[i].ratingAvgCC[k]==0||teacher[i].ratingAvgCC[k]==""||teacher[i].ratingAvgCC[k]==null){
                                array+=teacher[i].ratingAvg[k]+0
                                array1[i]=array



                            }
                            else{
                            array+=teacher[i].ratingAvg[k]+teacher[i].ratingAvgCC[k]
                            }
                        }
                        array1[i]=array

                        array=0
                    }
                    else if(teacher[i].ratingAvg.length<teacher[i].ratingAvgCC.length){
                        for(k=0;k<teacher[i].ratingAvgCC.length;k++){
                            if(teacher[i].ratingAvg[k]==0||teacher[i].ratingAvg[k]==""||teacher[i].ratingAvg[k]==null){
                                array+=teacher[i].ratingAvgCC[k]
                                array1[i]=array
                            }
                            else{
                            array+=teacher[i].ratingAvg[k]+teacher[i].ratingAvgCC[k]
                            }
                        }
                        array1[i]=array
                        array=0

                    }
                    else{
                        for(k=0;k<teacher[i].ratingAvgCC.length;k++){
                            array+=teacher[i].ratingAvg[k]+teacher[i].ratingAvgCC[k]
                        }
                        array1[i]=array
                        array=0
                    }
                }
            }
            else if(teacher[i].ratingAvg.length==0){
                if(teacher[i].ratingAvgCC.length!=0){
                for(j=0;j<teacher[i].ratingAvgCC.length;j++){
                    array+=teacher[i].ratingAvgCC[j]
                   
                   }

                       array1[i]=array
                       array=0;
                      

            }
        }
        }
        
        var c
        var c1=0
        var Cancel=0
        var Complete = 0
        var sum=0;
        var sum1=0;
        var sum2=0;
        var flag=0;
        var FinalArray =[]
        for(c1=0;c1<teacher.length;c1++){
           sum=teacher[c1].ratingAvgCC.length
           sum1=teacher[c1].ratingAvg.length
           sum2=sum+sum1
             FinalArray[c1]=array1[c1]/sum2

        
        
        }
         var Array1 = []
         var w;
         for(w=0;w<FinalArray.length;w++){

            Array1[w]=FinalArray[w].toFixed(1)
         }

      
    res.status(200).send(Array1.toString())
    
          
        
    } catch (e) {
        res.status(500).send()
    }
})


//

router.post('/Ttasks/RESCHD',auth1, async (req, res) => {
    try {
        const user1= await Teacher.findOne({name:req.teacher.name}) 
        const user2 = await Task.findOne({Name:req.body.Name})
        const ttassk = await TTask.findOne({owner:req.teacher._id})

             const count = ttassk.Students.length
             const countBreak = ttassk.BreakDate.length
             
             var p;
             var p1;
             for(p=0;p<countBreak;p++){
                 if(req.body.Date==ttassk.BreakDate[p]){
                   
                      if(req.body.Time==ttassk.BreakTime[p]){
                        res.status(400).send("YOUHAVEBREAK")
                         return 

                      }     
                     
                    

                 }
             }
             
               var TempJ=0;
             for(var j=0;j<count;j++){
                 if(req.body.Name==ttassk.Students[j]){
                           
                    TempJ=j;

                    break;
                 }
             }
         var i;
         var j1;
        


         for(i=0;i<count;i++){
             if(req.body.Date==ttassk.DateS[i]||req.body.Date==user2.Date){
             for(j1= 0;j1<count;j1++){
                     
                

                    if(req.body.Time==ttassk.TimeS[j1]||req.body.Time==user2.Time){
                        res.status(404).send("This Date is Already booked!")
                        return

                        
                    }        

            }


            user2.Date=req.body.Date
            user2.Time=req.body.Time
            user2.toggle="1"
            ttassk.DateS[TempJ] = req.body.Date
            ttassk.TimeS[TempJ]=req.body.Time
         

            
            await ttassk.save()

            await user2.save()
            res.status(200).send("Date-is-Updated")
        }
    
        }


       user2.Date=req.body.Date
            user2.Time=req.body.Time
            user2.toggle="1"
            ttassk.DateS[TempJ] = req.body.Date
            ttassk.TimeS[TempJ]=req.body.Time
            console.log(user2.Name)
            console.log(user2.Time)

            await ttassk.save()
            await user2.save()
            res.status(200).send("Date-is-Updated")
         
            
            res.status(200).send(ttassk.About)

        //  res.status(200).send(count.toString())

          
        
    } catch (e) {
        res.status(500).send()
    }
})


//
router.get('/Ttasks/TeachersCount', async (req, res)=>{
    try{
    const user = await TTask.find({})
    const count = user.length
    res.status(200).send(count.toString())
    }catch(e){
        res.status(400).send(e)
    }
    
    })
    
    router.get('/Ttasks/TeachersNames', async (req, res) => {
        try {
            const user = await Teacher.find({})
       
            // await user2.populate('owner')
            var array=[]
            var count = user.length
            var i;
            for(i=0;i<count;i++){
                array[i]=user[i].name
            }
            res.status(200).send(array.toString())
    
        } catch (e) {
            res.status(500).send()
        }
    })
    
    router.get('/Ttasks/TeacherInstrument', async (req, res) => {
        try {
               const user1 = await TTask.find({})
            // await user2.populate('owner')
            var array=[]
            var count = user1.length
            var i;
            console.log("hi")
            for(i=0;i<count;i++){

              

                array[i]=user1[i].instrument
            }
            res.status(200).send(array.toString())
    
        } catch (e) {
            res.status(500).send()
        }
    
        
    })
    
    router.get('/Ttasks/TeacherRatring', async (req, res) => {
        try {
            const user = await TTask.find({})
       
            // await user2.populate('owner')
            var array=[]
            var count = user.length
            var i;
            for(i=0;i<count;i++){
                if(user[i].ratingAvg[i] == null){
                    array[i]=0;
                    continue
                }
                array[i]=user[i].ratingAvg[i]
            }
            res.status(200).send(array.toString())
    
        } catch (e) {
            res.status(500).send()
        }
    
        
    })
    
    router.get('/Ttasks/TeacherEmail', async (req, res) => {
        try {
           const user1 = await Teacher.find({})
            var array=[]
            var count = user1.length
          
            var i;
            for(i=0;i<count;i++){
               
               
    
                array[i]=user1[i].email
    
            }
            res.status(200).send(array.toString())
    
        } catch (e) {
            res.status(500).send()
        }
    
        
    })


//

router.post('/Ttasks/BreakTime', auth1 ,async (req, res) => {
    try {

        const teacher1 = await TTask.findOne({owner:req.teacher.id})
        const count = teacher1.BreakDate.length
        const count1 = teacher1.DateS.length
        var i;
        var j;
        var i1;
        var j1;
        var k1;
        var k2;
      for(i1=0;i1<count1;i1++){
         if(req.body.BreakDate==teacher1.DateS[i1]){
             for(j1=0;j1<count1;j1++){
                 if(req.body.BreakTime==teacher1.TimeS[j1]){
                     res.status(400).send("you cant")
                     return
                 }
             }

         }


      }
    
        for(i=0;i<count;i++){
               if(teacher1.BreakDate[i]==req.body.BreakDate){
                   for(j=0;j<count;j++){
                   if(teacher1.BreakTime[j]==req.body.BreakTime){
                    console.log("Already have a break!")
                        res.status(400).send("Already have a break!")
                        return;
                   }
                }
               }
              


        }
       const teacher = await TTask.findOneAndUpdate({owner:req.teacher.id},
        {
            $push:{
              BreakDate:req.body.BreakDate,
              BreakTime:req.body.BreakTime

            }
        }  
        
        )

    
        await teacher.save()
        res.status(200).send(teacher)

    } catch (e) {
        res.status(500).send()
    }

    
})


router.post('/Ttasks/BreakDelete', auth1 ,async (req, res) => {
    try {

        const teacher1 = await TTask.findOne({owner:req.teacher.id})
        const count = teacher1.BreakDate.length
        var i;
        var j;

    
        for(i=0;i<count;i++){
               if(teacher1.BreakDate[i]==req.body.BreakDate){
                   for(j=0;j<count;j++){
                   if(teacher1.BreakTime[j]==req.body.BreakTime){
                     teacher1.BreakTime.splice(j,1)
                     teacher1.BreakDate.splice(i,1)   
                       await teacher1.save()
                        res.status(200).send("Deleted")
                        return;
                   }
                }
               }
              


        }
        res.status(400).send("No")

    } catch (e) {
        res.status(500).send()
    }

    
})

router.post('/Ttasks/UpdateName', async (req, res) => {
    try {
        const teacher = await Teacher.findOne({name:req.body.NName})

        const tasks = await TTask.findOne({NName:teacher.name})
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
        if(teacher&&tasks){
            teacher.name = req.body.name
            tasks.NName = req.body.name
            await teacher.save()
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

router.post('/Ttasks/UpdateSalary', async (req,res)=>{
    try{
const teacher = await Teacher.findOne({name:req.body.name})

if(teacher){
    teacher.Salary = req.body.Salary
    await teacher.save()
    res.status(200).send("Updated")
    return
}
res.status(400).send("Error")
return
    }catch(e){
        res.status(400).send(e)
    }
})

router.post('/Ttasks/UpdateCourse', async (req, res) => {
    try {
        const teacher = await TTask.findOne({NName:req.body.NName})
        const course = await Courses.findOne({name:req.body.instrument})
        if(!course){
            res.status(400).send("Not Exist")
            return

        }
        const count1 = teacher.Students.length
        const count3 = course.length
   

        if(teacher.instrument==req.body.instrument){
            res.status(400).send("Already teacher for this instrument")
            return 

        }
        else{
        teacher.instrument=req.body.instrument
        await teacher.save()
 
    }


        const string = teacher.owner

       const tasks = await Task.find({})
       const tasks1 = await Task.find({})

       const count = tasks.length
       var i;
       var j;

       for(i=0;i<count;i++){
        if(tasks1[i].owner2==null||tasks1[i].owner2==""){
            continue
      }  
        await tasks[i].populate("owner2")
             if(tasks[i].owner2.id.toString()==string.toString()){
                 

                tasks1[i].Date=""
                tasks1[i].Time=""
                tasks1[i].instrument=""
                tasks1[i].owner2=""
                tasks1[i].rating=""
                

                await tasks1[i].save()
             }

       }
       teacher.Students.splice(0)
       teacher.DateS.splice(0)
       teacher.TimeS.splice(0)
       teacher.ratings.splice(0)
       teacher.StudentImage.splice(0)
        var k;
        const tasksF = await User.find({})
        const tasksF1 = await User.find({})

        const count2 = tasksF.length
        for(k=0;k<count2;k++){
            if(tasksF1[k].owner1==null||tasksF1[k].owner1==""){
                continue
          } 
            await tasksF[k].populate("owner1")
          if(tasksF[k].owner1.id==string.toString()){
                  tasksF1[k].owner1=""
                  await tasksF1[k].save()
          }
        }
      
       await teacher.save()
 
         res.status(200).send("Updated")

     

        }catch (e) {
            res.status(500).send()
        }
    })
    
    router.post('/Ttasks/RemoveFromCompleted',auth1, async (req, res) => {
        try {
            const teacher1 = await TTask.findOne({owner: req.teacher.id})
            var test = teacher1.CompS
            const count = test.length
                
             var i;
             for(i=0;i<count;i++){
                if(req.body.name==teacher1.CompS[i]){
                     teacher1.CompS.splice(i,1)
                     teacher1. CompSD.splice(i,1)
                     teacher1.CompST.splice(i,1)
                     teacher1.CompSinstrument.splice(i,1)
                     teacher1.StudentImageCO.splice(i,1)
                     await teacher1.save()

                }
             }
    
       
        res.status(200).send("Removed")
              return 
               
    }
            
         catch (e) {
            res.status(500).send()
        }
    })       


    router.post('/Ttasks/RemoveFromCanceled',auth1, async (req, res) => {
        try {
            const teacher1 = await TTask.findOne({owner: req.teacher.id})
            var test = teacher1.CanceledS
            const count = test.length
             var arr=[]
             var i;
             for(i=0;i<count;i++){
                if(req.body.name==teacher1.CanceledS[i]){
                     teacher1.CanceledS.splice(i,1)
                     teacher1.CanceledSD.splice(i,1)
                     teacher1.CanceledST.splice(i,1)
                     teacher1.CanceledSInstrument.splice(i,1)
                     teacher1.StudentImageCA.splice(i,1)
                     
                     await teacher1.save()

                }
             }
    
       
        res.status(200).send("Removed")
              return 
               
    }
            
         catch (e) {
            res.status(500).send()
        }
    })


    router.post('/Ttasks/DisplayChoosenAboutS', async (req, res) => {
       
        const user = await TTask.find({});
    
        const count = user.length
        var i;
        var E
        for(i=0;i<count;i++){
            if(req.body.name==user[i].NName){
                    E=user[i].About
            }
        }
        
       res.status(200).send(E)
       }, (error, req, res, next) => {
           res.status(400).send({ error: error.message })
       })
    
    
       router.post('/Ttasks/DisplayChoosenNameS', async (req, res) => {
           
        const user = await TTask.find({});
    
        const count = user.length
        var i;
        var E
        for(i=0;i<count;i++){
            if(req.body.name==user[i].NName){
                    E=user[i].NName
            }
        }
        
       res.status(200).send(E)
       }, (error, req, res, next) => {
           res.status(400).send({ error: error.message })
       })
    
       router.post('/Ttasks/DisplayChoosenImageS', async (req, res) => {
           
        const user = await TTask.find({});
    
        const count = user.length
        var i;
        var E
        for(i=0;i<count;i++){
            if(req.body.name==user[i].NName){
                     await user[i].populate("owner")
                     if(user[i].owner.avatar!=null){
                        E = user[i].owner.avatar.toString("base64")
                     }
            }
        }
        
       res.status(200).send(E)
       }, (error, req, res, next) => {
           res.status(400).send({ error: error.message })
       })
    
    
       router.post('/Ttasks/DisplayChoosenPhoneS', async (req, res) => {
           
        const user = await TTask.find({});
    
        const count = user.length
        var i;
        var E
        for(i=0;i<count;i++){
            if(req.body.name==user[i].NName){
                     await user[i].populate("owner")
                        E = user[i].owner.Phone
                     
            }
        }
        
       res.status(200).send(E)
       }, (error, req, res, next) => {
           res.status(400).send({ error: error.message })
       })  

       router.get('/Ttasks/COUNTS',auth1, async (req, res) => {
        try {
            const teacher = await TTask.findOne({ owner: req.teacher.id})
           const Count = teacher.Students.length
           
        res.status(200).send(Count.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 


    router.get('/Ttasks/StudentsNames', async (req, res) => {
        try {
            const teacher = await TTask.find({})
            
           const Count = teacher.length
           var i;
           var j;
           var array=[]
           var k=0;
           for(i=0;i<Count;i++){
               const Count1 = teacher[i].Students.length
                 for(j=0;j<Count1;j++){
                     array[k]=teacher[i].Students[j]
                      k++;
                }

           }
        res.status(200).send(array.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 

    router.get('/Ttasks/StudentsDates', async (req, res) => {
        try {
            const teacher = await TTask.find({})
            
           const Count = teacher.length
           var i;
           var j;
           var array=[]
           var array1=[]
           var St;
           var k=0;
           for(i=0;i<Count;i++){

               const Count1 = teacher[i].DateS.length
                 for(j=0;j<Count1;j++){
                     array[i]=teacher[i].DateS[j]
                     St = array[i].toString().split(" ")
                     array1[k] = St[0]
                     k++

                }

           }
        res.status(200).send(array1.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 

    router.get('/Ttasks/StudentsCountss', async (req, res) => {
        try {
               const tasks = await TTask.find({})
               const counter =  tasks.length
               var i;
            var array=[]
            for(i=0;i<counter;i++){
                array[i] = tasks[i].Students.length
            }

        res.status(200).send(array.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    })
        
    
    router.get('/Ttasks/StudentsTimesss', async (req, res) => {
        try {
            const teacher = await TTask.find({})
            
           const Count = teacher.length
           var i;
           var j;
           var array=[]
           var array1=[]
           var St;
           var k=0;
           for(i=0;i<Count;i++){

               const Count1 = teacher[i].TimeS.length
                 for(j=0;j<Count1;j++){
                     array[i]=teacher[i].TimeS[j]
                     St = array[i].toString().split("-")
                     array1[k] = St[0]
                     k++

                }

           }
        res.status(200).send(array1.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 

    router.get('/Ttasks/StudentInstrumentsss', async (req, res) => {
        try {
            const teacher = await TTask.find({})
            
           const Count = teacher.length
           var i;
           var j;
           var array=[]
           var k=0;
           for(i=0;i<Count;i++){
               const Count1 = teacher[i].Students.length
               if(Count1!=0){
                 for(j=0;j<Count1;j++){
                     array[k]=teacher[i].instrument
                      k++;
                }
            }
            else{continue}

           }
        res.status(200).send(array.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 


    router.get('/Ttasks/COUNTS',auth1, async (req, res) => {
        try {
            const teacher = await TTask.findOne({ owner: req.teacher.id})
           const Count = teacher.Students.length
           
        res.status(200).send(Count.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 


    router.post('/Ttasks/TeachersBCount', async (req, res) => {
        try {
            const teacher = await TTask.findOne({NName:req.body.name})
            
           const Count = teacher.BreakDate.length
        
        res.status(200).send(Count.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 

    router.post('/Ttasks/TeachersBDates', async (req, res) => {
        try {
            const teacher = await TTask.findOne({NName:req.body.name})
           const Count = teacher.BreakDate.length
           var array =[]
           var i;
           var split;

           for(i=0;i<Count;i++){

                split = teacher.BreakDate[i].toString().split(" ")


                array[i] = split[0]
           }
              
        res.status(200).send(array.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 
    router.post('/Ttasks/TeachersBTimes', async (req, res) => {
        try {
            const teacher = await TTask.findOne({NName:req.body.name})
            
           const Count = teacher.BreakTime.length
           var array =[]
           var i;
           var split;
           for(i=0;i<Count;i++){
                array[i] = teacher.BreakTime[i]
           }
        res.status(200).send(array.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    })



    router.post('/Ttasks/TeachersBCount1', async (req, res) => {
        try {
            const teacher = await TTask.findOne({NName:req.body.name})
            
           const Count = teacher.DateS.length
        
        res.status(200).send(Count.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 

    router.post('/Ttasks/TeachersBDates1', async (req, res) => {
        try {
            const teacher = await TTask.findOne({NName:req.body.name})
           const Count = teacher.DateS.length
           var array =[]
           var i;
           var split;

           for(i=0;i<Count;i++){

                split = teacher.DateS[i].toString().split(" ")


                array[i] = split[0]
           }
              
        res.status(200).send(array.toString())
        
              
            
        } catch (e) {
            res.status(500).send()
        }
    }) 
    router.post('/Ttasks/TeachersBTimes1', async (req, res) => {
        try {
            const teacher = await TTask.findOne({NName:req.body.name})
            
           const Count = teacher.TimeS.length
           var array =[]
           var i;
           var split;
           for(i=0;i<Count;i++){
                array[i] = teacher.TimeS[i]
           }

        res.status(200).send(array.toString())
                  
            
        } catch (e) {
            res.status(500).send()
        }
    })

module.exports = router