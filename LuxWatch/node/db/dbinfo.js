var mssql = require('mssql');

const config = {
    driver:'SQL Server',
    server: 'LAPTOP-92OTJI7U\\SQLEXPRESS',
    user: 'sa',
    password: '172002',
    database: 'QuanLyCuaHangDongHo<project2021.2>',
    options:{
        encrypt: false,
        enableArithAbort: false,
    },
    connectionTimeout:300000,
    requestTimeout:300000,
    pool:{
        idleTimeoutMillis:300000,
        max: 100,
    },
    port: 1433
};

const pool = new mssql.ConnectionPool(config);
module.exports={
    pool,
};
