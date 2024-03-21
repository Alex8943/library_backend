import express from 'express';
import {testDBConnection} from './db_services/mysql_conn_setup';
import logger from './other_services/winstonLogger';
import bookRouter from './routes/bookRouter'
import bookAuthor from './routes/bookAuthor'
import tagRouter from './routes/tagRouter'
import authorRouter from './routes/authorRouter'
import userTabRouter from './routes/userTabRouter'

const app = express();

//Mysql connection test
//testDBConnection(); 

//Testing my routes
app.use(bookRouter)
app.use(bookAuthor)
app.use(tagRouter)
app.use(authorRouter)
app.use(userTabRouter)
//app.use(userRouter)



//Do this when the server ends 
process.on('SIGINT', (code) => {
    logger.end(); 
    console.log('See ya later silly');
    process.exit(0);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});