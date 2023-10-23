const express = require('express')
require('./db/mongoose')
const jwt = require('jsonwebtoken')
const bcrypt = require("bcrypt")
const userRouter = require('./routers/users')
const taskRouter = require('./routers/task')
const TeacherRouter = require('./routers/Teachers')
const TTASK = require('./routers/Ttask')
const Admin= require('./routers/Admin')

const cors = require("cors");
const Courses= require('./routers/Courses')
const Instruments= require('./routers/ShoppingInstruments')
// 
const app = express()
const port = process.env.PORT || 3000
var bodyParser = require('body-parser');
app.use(cors());

app.use(bodyParser.json({limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true, parameterLimit: 50000 }));
app.use(express.json())
app.use(userRouter)
app.use(taskRouter)
app.use(TeacherRouter)
app.use(Admin)

app.use(Courses)
app.use(TTASK)
app.use(Instruments)



app.listen(port, ()=>{
console.log('Server is up on port '+ port)
}) 
// const myFunction = async ()=> {
//  const token = jwt.sign({_id:'abc123'},'thisismynewcourse',{expiresIn:'7 days'})
// console.log(token)
// const data = jwt.verify(token, 'thisismynewcourse')
// console.log(data)
// }
// myFunction()
const Task = require('./models/task')
const User = require('./models/user')
const TTask = require('./models/Ttask')
const Teacher = require('./models/teacher')
// const main = async ()=>{
//     const task = await User.findOne({name:"AhmadSadouq1"})

//     await task.populate('owner1')
        
//     console.log(task.owner1.name)

// }

// main()
