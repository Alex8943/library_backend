import express from 'express';
import {testDBConnection} from './db_services/mysql_conn_setup';
const app = express();

//Mysql connection test
testDBConnection(); 

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});