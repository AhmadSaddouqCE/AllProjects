const jwt = require('jsonwebtoken')
const Admin = require('../models/Admin')


const AdminAuth = async (req, res, next) => {
    try {
        const token = req.header('Authorization').replace('Bearer ', '')
        const decoded = jwt.verify(token, 'thisismynewcourse')
        const Admin = await Admin.findOne({ _id: decoded._id, 'tokens.token': token })


         console.log(decoded._id);
        if (!user) {
            throw new Error()
        }
          req.token = token
        req.Admin = Admin
        next()
    } catch (e) {
        res.status(401).send({ error: 'Please authenticate.' })
    }
}

module.exports = AdminAuth