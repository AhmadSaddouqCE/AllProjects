const express = require('express')
const Admin = require('../models/Admin')
const AdminAuth= require('../middleware/AdminAuth')
const multer = require('multer')
const sharp = require('sharp')
const Task = require('../models/task')

const router = new express.Router()


const upload = multer({
    limits: {
        fileSize: 1000000
    },
})
router.post('/Admin/log',  async (req, res)=>{
try{
  const Admin1 = await Admin.findUser1(req.body.name,req.body.password)
  
   const token = await Admin1.generateAuthToken()

   res.send({Admin1,token})
   
}
 catch(e){
    console.log(e)
res.status(400).send()
}
})





router.post('/Admin/logout', AdminAuth, async (req, res) => {
   try {
       req.Admin.tokens = req.Admin.tokens.filter((token) => {
           return token.token !== req.token
       })
       await req.Admin.save()

       res.send()
   } catch (e) {
       res.status(500).send()
   }
})



   
   

   router.get('/Admin/me', AdminAuth , async (req, res) => {
      res.send(req.Admin)
  })







//-------------------

router.post('/Admin',  async (req,res)=>{
    try{
        const Admin1 = new Admin (req.body)

          
    await Admin1.save();

   const token = await Admin1.generateAuthToken()


    res.status(201).send({Admin1,token})

 


 
    } catch(e){
    res.status(400).send(e)
    }
    
    })

    router.post('/Admin/CountHelps',  async (req,res)=>{
        try{
            const Admin1  = await Admin.findOne({name:req.body.name})
            const counthelp = Admin1.HelpName.length
       
           
        res.status(200).send(counthelp.toString())
    
     
        } catch(e){
        res.status(400).send(e)
        }
        
        })

        router.post('/Admin/RemoveContact',  async (req,res)=>{
            try{
                const Admin1  = await Admin.findOne({name:req.body.name})
                const count = Admin1.HelpName.length
                var i;
                for(i=0;i<count;i++){
                    if(req.body.nameS==Admin1.HelpName[i]){
                        Admin1.HelpName.splice(i,1)
                        Admin1.HelpDescription.splice(i,1)
                    }
                }
              
                  await Admin1.save()
            res.status(200).send(Admin1)
        
         
            } catch(e){
            res.status(400).send(e)
            }
            
            })


    router.post('/Admin/HelpStudents',  async (req,res)=>{
        try{
            const Admin1  = await Admin.findOne({name:req.body.name})
              console.log(Admin1)
            var array=[]
            const counthelp = Admin1.HelpName.length
            var i;
            for(i=0;i<counthelp;i++){
               array[i] = Admin1.HelpName[i]
            
            }
           
        res.status(200).send(array.toString())
    
     
        } catch(e){
        res.status(400).send(e)
        }
        
        })

        router.post('/Admin/HelpStudentsD',  async (req,res)=>{
            try{
                const Admin1  = await Admin.findOne({name:req.body.name})
                var array=[]
                const counthelp = Admin1.HelpDescription.length
                var i;
                for(i=0;i<counthelp;i++){
                   array[i] = Admin1.HelpDescription[i]
                
                }
               
            res.status(200).send(array.toString())
        
         
            } catch(e){
            res.status(400).send(e)
            }
            
            })
            
    router.post('/Admin/SendStudentProblem',  async (req,res)=>{
        try{
            const tasks = await Task.findOneAndUpdate(
                {
                Name:req.body.name
                },
                {
                    $push:{
                        HelpResponced:req.body.Message
                    }
                }
                
                )
                tasks.toggleM="1"
           await tasks.save()
           
        res.status(200).send(tasks)
    
     
        } catch(e){
        res.status(400).send(e)
        }
        
        })

module.exports = router