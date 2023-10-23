const jwt1 = require('jsonwebtoken')
const Teacher = require('../models/teacher')

const auth1 = async (req, res, next) => {
    try {
        const token = req.header('Authorization').replace('Bearer ', '')
        const decoded = jwt1.verify(token, 'thisismynewcourse')
        const teacher = await Teacher.findOne({ _id: decoded._id, 'tokens.Ttoken': token })
         console.log(decoded._id);
         
     
        if (!teacher) {
            throw new Error()
        }
          req.token = token
        req.teacher = teacher
        next()
    } catch (e) {

        res.status(401).send({ error: 'Please authenticate.' })
    }
}

module.exports = auth1