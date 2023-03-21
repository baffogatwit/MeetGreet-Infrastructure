// MeetGreet API
const express = require("express");

const app = express();

const PORT = 5500;

const sql = require("mysql2");
// const dbConfig = require("../config/db.config.js");

// Create a connection to the database
const connection = sql.createConnection({
	host: "localhost",
	user: "root",
	password: "replace_password",
	database: "MEETGREET"
});

// open the MySQL connection
connection.connect(error => {
	if (error) throw error;
	console.log("Successfully connected to the database.");
});

module.exports = connection;

// API Endpoints

app.listen(PORT, () => {
	console.log("Server Running on PORT", PORT);
})

app.get("/health-check", (req, res) => {
	res.json({ message: "Server up and running" });
})

app.get("/sign-in-user/:email/:password", async (req, res) => {
	const email = req.params.email;
	const password = req.params.password;
	const isVerified = req.params.isVerified;

	const query = `SELECT * FROM User WHERE Email = \"${email}\" && password = \"${password}\";`;
	console.log(query);
	const rows = await connection.promise().query(query)
		.then(([rows, fields]) => {
			if (rows.length == 0) {
				res.json("User does not exist.");
			} else {
				const status = "OK";
				const message = "User successfully signed in."

				const userID = rows[0]["ID"];
				const email = rows[0]["Email"];
				const isEmailVerified = rows[0]["IsEmailVerified"];

				const userInfo = {userID, email, isEmailVerified};

				res.json({status, message, userInfo });
			}

		})
		.catch((error) => {
			const status = "BAD";
			res.json(status, error);
		});
})

app.post("/register-user/:email/:password", async (req, res) => {
	const email = req.params.email;
	const password = req.params.password;

	const query = `INSERT INTO User (Email, IsEmailVerified, Password) VALUES (\"${email}\", 0, \"${password}\");`;
	const userDataQuery = `SELECT ID, Email, IsEmailVerified FROM User WHERE Email = \"${email}\"`;


	const createUser = await connection.promise().query(query)
		.then(async ([rows, fields]) => {
			const status = "OK";
			return { status, rows };
		})
		.catch((error) => {
			if (error["code"] == "ER_DUP_ENTRY") {
				const status = "BAD";
				const message = "A user with this email already exists.";
				return { status, message };
			} else {
				const status = "BAD";
				const message = "An unexpected error occured. Please try again later.";
				return { status, message };
			}
		});

	if (createUser["status"] == "BAD") {
		res.json(createUser);
	} else {
		const userInfoRows = await connection.promise().query(userDataQuery)
			.then(async ([rows, fields]) => {
				const status = "OK";
				const message = "User successfully created.";
				const userID = rows[0]["ID"];
				const email = rows[0]["Email"];

				res.json({ status, message, userID, email });

			}).catch((error) => {
				console.log(error);
				const status = "OK";
				const message = "User successfully created. Unable to retrieve user information from the database, please try again.";
				res.json({ status, message });
			});
	}
})


app.get("/get-events", (req, res) => { })
app.get("/search-for-events", (req, res) => { })
app.post("/create-event", (req, res) => { })