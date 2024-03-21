import express from 'express';
import conn from '../db_services/mysql_conn_setup';
import logger from '../other_services/winstonLogger';

const router = express.Router();
router.use(express.json());

// Get all tags
router.get("/tags", async (req, res) => {
    try {
        const result: any = await getAllTags();
        res.status(200).send(result);
    } catch (err) {
        console.log(err);
        res.status(500).send("Something went wrong with fetching tags");
    }
});

export async function getAllTags() {
    const connection = await conn.getConnection();
    try{
        const [rows] = await connection.query(`SELECT * FROM tags`);
        connection.release();
        return rows;
    }catch(err){
        logger.error("Error getting all tags: [getAllTags, 2]", err);
        connection.release();
    }
}

// create tag
router.post("/tag", async (req, res) => {
    try {
        const result: any = await createTag(req.body);
        res.status(200).send(result);
    } catch (err) {
        console.log(err);
        res.status(500).send("Something went wrong with creating tag");
    }
});

export async function createTag(values: any) {
    const connection = await conn.getConnection();
    try{
        const [rows] = await connection.query(`INSERT INTO tags (title, tag_description) VALUES (?,?)`, [
            values.title, 
            values.tag_description
        ]);
        connection.release();
        return rows;
    }catch(err){
        logger.error("Error creating tag: [createTag, 2]", err)
        connection.release();
    }
}

//Cannot add or update a child row: a foreign key constraint fails (`bookstore`.`tag_books`, CONSTRAINT `tag_books_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`))
//TODO: Fix this error
router.post("/bookTag", async (req, res) => {
    try {
        const result: any = await addTagToBook(req.body);
        res.status(200).send(result);
    } catch (err) {
        console.log(err);
        res.status(500).send("Something went wrong with adding tag to book");
    }
});

export async function addTagToBook(values: any) {
    const connection = await conn.getConnection();
    try{
        const [rows] = await connection.query(`INSERT INTO tag_books (book_id, tag_id) VALUES (?,?)`, [
            values.book_id, 
            values.tag_id
        ]);
        connection.release();
        return rows;
    }catch(err){
        logger.error("Error adding tag to book: [addTagToBook, 2]", err)
        connection.release();
    }
}

export default router;