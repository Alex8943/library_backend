import express from 'express';
import {testDBConnection} from './db_services/mysql_conn_setup';
import job from './other_services/cronjob';
import logger from './other_services/winstonLogger';
import bookRouter from './routes/bookRouter'
import authorRouter from './routes/authorRouter'
import tagRouter from './routes/tagRouter'
import authRouter from './routes/authRouter'
import userTabRouter from './routes/userTabRouter'
import userRouter from './routes/userRouter'
import cors from 'cors';

const app = express();
app.use(cors()); 

//testDBConnection(); 

//cronjob test
//job.start();


app.use(authorRouter) //Error: Delete author does not work, invalid status code 1
app.use(tagRouter) // Error: Cannot add tag to book
app.use(authRouter) 
app.use(bookRouter)
app.use(userTabRouter) 
app.use(userRouter)



process.on('SIGINT', (code) => {
    logger.end(); 
    console.log('See ya later silly');
    process.exit(0);
});


app.listen(3000, () => {
    console.log('Server is running on port 3000');
});