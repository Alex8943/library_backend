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
import swaggerUi from 'swagger-ui-express';
import swaggerJsdoc from "swagger-jsdoc";

const app = express();
app.use(cors()); 

//testDBConnection(); 

//cronjob test
//job.start();


const options = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "Library API documentation",
            version: "1.0.0",
            description: "code documentation for our library project",
        },
    },
    apis: [
        './src/routes/swagger_openAPI_routes/author_router.yaml', 
        './src/routes/swagger_openAPI_routes/book_router.yaml', //Create book does not work
        './src/routes/swagger_openAPI_routes/tag_router.yaml'
    ],
};

app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerJsdoc(options)));


app.use(authorRouter) //Error: Delete favorite author does not work, invalid status code 1. Create author does not work
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