const express = require('express');
const router = express.Router();
const {pool}=require('../db/dbinfo');

// get data
// define api get, post,patch,put,delete

// async await

router.get('/',async (req, res) => {
    try {
        await pool.connect()
        const result = await pool.request().query('select * from KhachHang')
        const test=result.recordset
        res.json(test)
        
        console.table(test);
    } catch (error) {
        res.status(500).json(error);
    }
});
module.exports  = router;