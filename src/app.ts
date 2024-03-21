import express from 'express';
import {testDBConnection} from './db_services/mysql_conn_setup';
import job from './other_services/cronjob';
import logger from './other_services/winstonLogger';
import bookRouter from './routes/bookRouter'
import bookAuthor from './routes/bookAuthor'
import tagRouter from './routes/tagRouter'
import authorRouter from './routes/authorRouter'
import userTabRouter from './routes/userTabRouter'

const app = express();

//Mysql connection test
//testDBConnection(); 

//cronjob test
//job.start();


app.use(bookRouter)
app.use(bookAuthor) //Error: Delete author does not work
app.use(tagRouter) // Error: Cannot add tag to book
app.use(authorRouter) // Error with deleting a favorited connection
app.use(userTabRouter) //jwt token gives error
//app.use(userRouter)




process.on('SIGINT', (code) => {
    logger.end(); 
    console.log('See ya later silly');
    process.exit(0);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});