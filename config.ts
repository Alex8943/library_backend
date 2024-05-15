// config.ts
import dotenv from 'dotenv';

dotenv.config();

const environment = process.env.NODE_ENV;
const commonConfig = {
    current_env: environment,
};

export const devConfig = {
    ...commonConfig,
    dbConfig: {
        mysql: {
            mysql_host: process.env.MYSQL_DEV_DB_HOST,
            mysql_user: process.env.MYSQL_DEV_DB_USERNAME,
            mysql_password: process.env.MYSQL_DEV_DB_PASSWORD,
            mysql_database: process.env.MYSQL_DEV_DB_NAME,
            mysql_port: process.env.MYSQL_DEV_DB_PORT,
        },
        APP_PORT: process.env.DEV_PORT,
    },
};


export const prodConfig = {
    ...commonConfig,
    dbConfig: {
            mysql: {
                mysql_host: process.env.MYSQL_PROD_DB_HOST,
                mysql_user: process.env.MYSQL_PROD_DB_USERNAME,
                mysql_password: process.env.MYSQL_PROD_DB_PASSWORD,
                mysql_database: process.env.MYSQL_PROD_DB_NAME,
                mysql_port: process.env.MYSQL_PROD_DB_PORT,
            },
        },
        APP_PORT: process.env.PROD_PORT,
};

export const config = (process.env.NODE_ENV == "production " ? devConfig : prodConfig);