const routePost = require('./router');
const dbConnection = require('../models/mysqlConnection');
// routePost = express.Router();

dbConnection.connect((err)=>{
    if(err){
        console.error('Connection Failed: ' + err.stack);
        return;
    }
    console.log('Connected as id ' + dbConnection.threadId);
})

routePost.post('/', async(req, res, next)=>{
    let sql = 'SELECT * FROM user_accounts WHERE Username = ? AND pass_word = ? AND user_role = "Admin"';
    let userID = req.body.username;
    let Password = req.body.pass_;
    try {
        dbConnection.query(sql, [userID, Password], (err, result, fields)=>{
            if(err) throw err;
            if(result.length > 0){
                req.session.loggedinUser = true;
                req.session.userID = userID;
                res.redirect('/adminIndex');
            }else{
                res.render('adminloginPage');
            }
            res.end();
        });
    } catch (error) {
        next(error);
    }
});


routePost.post('/employees', async(req, res, next)=>{
    let employeeID = req.body.identity;
    let firstName = req.body.fname;
    let lastName = req.body.lname;
    let dob = req.body.dob;
    let email = req.body.mail;
    let stats = req.body.status;
    try {
        const query = "INSERT INTO employees (empid, firstName, lastName, dateOfBirth, email, status) VALUES (?,?,?,?,?,?)"
        dbConnection.query(query, [employeeID, firstName, lastName, dob, email, stats] , (err, result, fields)=>{
            if(err) throw err
            return res.render('employee');
        })
    } catch (error) {
        
    }
})

routePost.post('/salary', async(req, res, next)=>{
    let employeeID = req.body.identity;
    let salaryID = req.body.salaryID;
    let MonthSalary = req.body.msalary;
    let yearlyBonus = req.body.ybonus;
    let tax = req.body.taxstatus;
    try {
        const query = "INSERT INTO salary (salaryID, empID, monthlySalary, yearlyBonus, taxInfo) VALUES (?,?,?,?,?)"
        dbConnection.query(query, [salaryID, employeeID, MonthSalary, yearlyBonus, tax] , (err, result, fields)=>{
            if(err) throw err
            return res.render('salary');
        })
    } catch (error) {
        
    }
})

routePost.post(`/yearwiseSalary/updateEmp/:empID`, async(req, res)=>{
    let employee = await 'UPDATE employees SET firstName = ?, lastName = ?, dateOfBirth = ?, email = ?, status = ? WHERE empID = ?';
    let name = req.body.fname;
    let lname = req.body.lname;
    let dob = req.body.dob;
    let email = req.body.mail;
    let stats = req.body.status;
    let employeeID = req.body.identity;
    dbConnection.query(employee, [name, lname, dob, email, stats, employeeID], (err, data)=>{
        if(err) throw err;
        else{
            res.render('update');
            console.log(data)
        }
    })
});

module.exports = routePost;