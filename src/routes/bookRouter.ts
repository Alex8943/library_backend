import express from "express"; 
import {Request} from "express"; 
import logger from "../other_services/winstonLogger";
import { Book as Books, Author, Review, Tag } from "../other_services/model/seqModels";
import { QueryTypes } from "sequelize";
import sequelize from "../other_services/sequalizerConnection";


const router = express.Router();
router.use(express.json());


// ---------------------- Get all books ----------------------
router.get("/books", async (req, res) => {
    try {
        const result = await getAllBooks();
        res.status(200).send(result);
    } catch (error) {
        logger.error("Error getting all books: [getAllbooks, 1]", error);
        res.status(500).send(error);
    }
});

export async function getAllBooks() {
    try {

        const books = await Books.findAll({
            include: [
                {
                    model: Review,
                    attributes: ["stars", "user_id"],
                },
                {
                    model: Author,
                    attributes: ["author_id", "username", "total_books"],
                },
                {
                    model: Tag,
                    attributes: ["title", "tag_description"],
                    through: {
                        attributes: [], 
                    }
                },
            ],
        });
        const bookArray = books.map((book) => book.toJSON());
        return bookArray;
    } catch (error) {
        logger.error("Error getting all books: [getAllbooks, 2]", error);
        throw error;
    }
}


export default router;