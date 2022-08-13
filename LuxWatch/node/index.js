const express = require('express');
// const dotenv = require('dotenv');

const app = express();
const cors = require('cors');
app.use(express.json());
app.use(cors());

app.use('/api/listemployee',require('./api/employeeApi'))
app.use('/api/listwatch',require('./api/watchApi'))
app.use('/api/listbranch',require('./api/branchApi'))
app.use('/api/listcustomer',require('./api/customerApi'))
app.use('/api/listbill',require('./api/billApi'))


app.listen(5500,()=>{
    console.log(`Server is running successfully !!!`);
})
