const express = require("express");

const app = express();

const PORT = 5500;

app.get("/", (req, res) => {
	res.json({ message: "Hello World"  });
})

app.get("/health-check", (req, res) => {
	res.json({ message: "Server up and running"  });
})

app.listen(PORT, () => {
	console.log("Server Running on PORT", PORT);
})


// MeetGreet API

app.post("/register-user", (req, res) => {
	const
	res.json({ message: "Hello World"  });
})

app.get("/sign-in-user", (req, res) => {
	res.json({ message: "Hello World"  });
})

app.get("/get-events", (req, res) => {
	res.json({ message: "Hello World"  });
})

app.get("/search-for-events", (req, res) => {
	res.json({ message: "Hello World"  });
})

app.post("/create-event", (req, res) => {
	res.json({ message: "Hello World"  });
})