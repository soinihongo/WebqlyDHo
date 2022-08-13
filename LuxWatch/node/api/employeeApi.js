const express = require('express');
const router = express.Router();
const {pool}=require('../db/dbinfo');

// get data
// define api get, post,patch,put,delete

// async await
router.post('/', async (req, res) => {
    try {
        var sqlInsert = 'INSERT into NhanVien(MaNV,TenNhanVien,GioiTinh,NgaySinh,CCCD,Email,SDT,LuongCung) values (@MaNV,@TenNhanVien,@GioiTinh,@NgaySinh,@NgaySinh,@CCCD,@Email,@SDT,@LuongCung)'
        await pool.connect()
        return await pool.request()
        .input('MaNV',sql.NChar,req.body.MaNV)
        .input('TenNhanVien',sql.NVarchar,req.body.TenNhanVien)
        .input('GioiTinh',sql.NChar,req.body.GioiTinh)
        .input('NgaySinh',sql.Date,req.body.NgaySinh)
        .input('CCCD',sql.NChar,req.body.CCCD)
        .input('Email',sql.NVarchar,req.body.Email)
        .input('SDT',sql.NChar,req.body.SDT)
        .input('LuongCung',sql.int,req.body.LuongCung)
        .query(sqlInsert,function(err,data){
            res.send({result:req.body});
        })
    } catch (error) {
        res.status(500).json(error);
    }
})
router.get('/',async (req, res) => {
    try {
        await pool.connect()
        const result = await pool.request().query('select * from NhanVien')
        const test=result.recordset
        res.json(test)
        
        console.table(test);
    } catch (error) {
        res.status(500).json(error);
    }
});

module.exports  = router;