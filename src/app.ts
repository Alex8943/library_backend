import express from 'express';
import {testDBConnection} from './db_services/mysql_conn_setup';
import logger from './other_services/winstonLogger';
const app = express();

//Mysql connection test
testDBConnection(); 


//Do this when the server ends 
process.on('SIGINT', (code) => {
    logger.end(); 
    console.log('See ya later silly');
    process.exit(0);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});