const express = require('express')
const Courses = require('../models/Courses')
const multer = require('multer')
const sharp = require('sharp')
const Teacher = require('../models/teacher')
const TTask = require('../models/Ttask')
const Task = require('../models/task')
const User = require('../models/user')




const router = new express.Router()


const upload = multer({
    limits: {
        fileSize: 5000000000
    },
})

router.post('/Courses', upload.single('upload'), async (req, res) => {
    const Course = await Courses.find({})
    const Count = Course.length
    var i;
    if(Count!=0){
    for(i=0;i<Count;i++){
       if(Course[i].name==req.body.name){
           res.status(400).send("Unique")
           return
       }
    }
}
    const courses = new Courses (req.body)
     
    const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
    courses.avatar = buffer

    await courses.save();
    

    res.status(201).send(courses)
}, (error, req, res, next) => {
    res.status(400).send("NoYou")
})


router.post('/Courses/getName', async (req, res) => {
 const Course = await Courses.find();
const count = Course.length
var array= [];
var i;
for(i=0;i<count;i++){
array[i]=Course[i].name
}
var arr1=array.toString()
var q1 = arr1.split(',')
 res.send(q1.toString())


}, (error, req, res, next) => {
    res.status(400).send({ error: error.message })
})
router.post('/Courses/count', async (req, res) => {
    const Course = await Courses.find();
   const count = Course.length
      
    res.send(count.toString())
   
   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Courses/Des', async (req, res) => {
    const Course = await Courses.find();
   const count = Course.length
   var array= [];
   var i;
   for(i=0;i<count;i++){
   array[i]=Course[i].Description
   }
   var arr1=array.toString()
   var q1 = arr1.split(',')
    res.send(q1.toString())
   
   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Courses/price', async (req, res) => {
    const Course = await Courses.find();
   const count = Course.length
   var array= [];
   var i;
   for(i=0;i<count;i++){
   array[i]=Course[i].Price
   }
   var arr1=array.toString()
   var q1 = arr1.split(',')
    res.send(q1.toString())
   
   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

router.post('/Courses/getImage', async (req, res) => {
    const Course = await Courses.find();
   const count = Course.length
   var array1=[];
   var i;
   for(i=0;i<count;i++){
   array1[i]=Course[i].avatar.toString("base64")
   }
   var arr=array1.toString()
    var q= arr.split(',')
    res.send(q.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Courses/ChangePrice', async (req, res) => {
    const Course = await Courses.findOne({name:req.body.name});
    
   if(Course){
      Course.Price = req.body.Price
      await Course.save()
      res.status(200).send("True")
      return

   }


    res.status(400).send("False")

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })


   router.get('/Courses/GetAllCoursesCount', async (req, res) => {
    const Course = await Courses.find({});
    const count = Course.length
    



    res.status(200).send(count.toString())

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Courses/ChangeDes', async (req, res) => {
    const Course = await Courses.findOne({name:req.body.name});
    
   if(Course){
      Course.Description = req.body.Description
      await Course.save()
      res.status(200).send("True")
      return

   }


    res.status(400).send("False")

   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })

   router.post('/Courses/DeleteCourse', async (req, res) => {
    const user = await User.find({})
    const teacher = await Teacher.find({})
   const TeacherTask = await TTask.find({})
   const countTeacherTask = TeacherTask.length
   const userTask = await Task.find({})
   const UserTask = userTask.length
   //
   const Course1 = await Courses.find({})
   const CountCourse = Course1.length


   //
   var i;
   var j;
   var k;
   for(i=0;i<CountCourse;i++){
    if(Course1[i].name=req.body.name){
      for(j=0;j<UserTask;j++){
          if(req.body.name==userTask[j].instrument){

              const DeleteUserOwner = await User.findOne({name:userTask[j].Name})
              if(!DeleteUserOwner){
                  continue
              }
              DeleteUserOwner.owner1=""
              userTask[j].instrument=""
              userTask[j].Date=""
              userTask[j].Time=""
              userTask[j].rating=""
              userTask[j].owner2=""
              await userTask[j].save()
              await DeleteUserOwner.save()

    }
      }
    }
   }
   for(k=0;k<countTeacherTask;k++){
       if(req.body.name == TeacherTask[k].instrument){
                TeacherTask[k].instrument = ""
                TeacherTask[k].Students.splice(0)
                TeacherTask[k].DateS.splice(0)
                TeacherTask[k].TimeS.splice(0)
                TeacherTask[k].ratings.splice(0)
                TeacherTask[k].StudentImage.splice(0)
                await TeacherTask[k].save()
       }

   }

   const Cours = await Courses.findOneAndDelete({name:req.body.name})

res.status(200).send("Deleted")
return



   
   }, (error, req, res, next) => {
       res.status(400).send({ error: error.message })
   })


module.exports = router