const express = require('express');
const session = require('express-session');
const dbConnection = require("../models/mysqlConnection");
const bcrypt = require('bcrypt');
const {validationResult} = require('express-validator');
const { select } = require('async');
const router = express.Router();


// Admin Login Pages
router.get('/', (req, res)=>{
    res.render('adminloginPage');
});

// Landing page for admins
router.get('/adminIndex', (req, res)=>{
    // res.render('adminIndex');
    const query = "SELECT count(*), (SELECT count(*) FROM employees WHERE status = 'active') AS active, (SELECT count(*) FROM employees WHERE status = 'deactive') AS deactive FROM employees"
    dbConnection.query(query, (err, result, fields)=>{
        if (err) throw err
        else{
            res.render('adminIndex', {
                employeedata: result
            })
        }
    })
})

router.get('/class', (req, res)=>{
    res.render('class');
});
router.get('/employees', (req, res)=>{
    res.render('employee');
});
router.get('/employeesReport', (req, res)=>{
    let empID = req.body.empID;
    const employee_info = "SELECT * FROM employees WHERE empID = ?"
    dbConnection.query(employee_info, [empID], (err, result, fields)=>{
        if (err) throw err
        else{
            res.render('employeeReport', {
                data: result
            })
        }
    })
});
router.get('/salary', (req, res)=>{
    res.render('salary');
});


router.get('/yearwiseSalary', async(req, res)=>{
    let employee = 'SELECT * FROM employees LEFT JOIN salary ON salary.empID = employees.empID';
    dbConnection.query(employee, (err, data)=>{
        if(err) throw err;
        else{
            res.render('yearwiseSalary', {
                action: 'list',
                sampleData: data,
            });
        }
    })
});

router.get(`/yearwiseSalary/updateEmp/:empID`, async(req, res)=>{
    res.render('update');
});

router.get(`/yearwiseSalary/deleteEmp/:empID`, async(req, res)=>{
    res.render('deletion');
});
router.delete('/yearwiseSalary/deleteEmp', async(req, res)=>{
    let deletetion = await "DELETE FROM employees WHERE empID = ?"
    let emp = req.body.data.empID
    dbConnection.query(deletetion, [])
});

router.get('/yearwiseReport', (req, res)=>{
    res.render('yearwiseReport');
});



module.exports = router;