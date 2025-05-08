
# Shoppy Chatbot

This project is a chatbot that connects to a MySQL database, loads chatbot rules from the database, and provides a GUI for users to log in, register, and interact with the chatbot. The chatbot can provide responses based on stored rules, manage user interactions, and save conversations.

## Requirements

- **MAMP** (or any local server with MySQL support)
- **MySQL Connector** (for connecting the IDE to the MySQL database)
- **Java** (for running the chatbot application)

## Setup Instructions

### Step 1: Install MySQL and Set Up MAMP

1. Download and install [MAMP](https://www.mamp.info/en/) (or any similar local server with MySQL support).
2. Start the MAMP server to run Apache and MySQL.
3. Open **phpMyAdmin** via the MAMP control panel.
4. Create a new database named **ShoppyDB**.

### Step 2: Import Database

1. Download the `ShoppyDB.sql` file from the repository (it's included in the project files).
2. In **phpMyAdmin**, select the **ShoppyDB** database.
3. Click the **Import** tab.
4. Choose the `ShoppyDB.sql` file and click **Go** to import the structure and initial data.

### Step 3: Set Up the MySQL Connector

1. Download the [MySQL Connector JAR file](https://dev.mysql.com/downloads/connector/j/) (the `mysql-connector-j-9.3.0.jar` file is included in the project).
2. Add the `mysql-connector-j-9.3.0.jar` to your IDE's classpath to enable connection to MySQL.

### Step 4: Configure Database Connection in Code

Ensure the `ShoppyChatbot.java` file has the correct connection URL, username, and password for your local MySQL setup.

```java
connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/ShoppyDB", "root", "root");
```

- **localhost**: Use `localhost` if running MySQL locally.
- **8889**: Default MySQL port in MAMP.
- **ShoppyDB**: Name of the database you imported.
- **root**: Default MySQL username.
- **root**: Default MySQL password (can be changed if desired).

### Step 5: Running the Chatbot

1. Open the project in your preferred Java IDE (e.g., IntelliJ IDEA, Eclipse).
2. Ensure that the `mysql-connector-j-9.3.0.jar` is added to the classpath.
3. Compile and run the `ShoppyChatbot.java` class.
4. The program will prompt you to log in. If you don't have a user, click on **Register** to create a new account.
5. After logging in, you will be able to chat with the bot based on the rules defined in the database.

### Step 6: Features of the Chatbot

- **Login and Registration**: Allows users to log in or register with basic details (username, password, email, etc.).
- **Chat Functionality**: Chat interface where users can interact with the chatbot.
- **Database-Driven Responses**: The chatbot will respond based on keywords stored in the database under the `chatbot_rules` table.
- **View Conversations**: Users can view their previous conversations.
- **Update and Delete Profile**: Users can update their email and phone number or delete their account.
- **Order History**: Users can view their order history.

### Step 7: Database Tables

The following tables should be created in the **ShoppyDB** database (based on the `ShoppyDB.sql` file):

- **users**: Stores user information (username, password, email, etc.).
- **chatbot_rules**: Contains the keywords and corresponding responses used by the chatbot.
- **conversations**: Stores chat history between the user and the chatbot.
- **orders**: Stores order information associated with users.

---

### Additional Notes

- **Security**: Passwords are stored in plain text in this project for simplicity. For a real-world application, you should hash passwords before storing them.
- **Error Handling**: The chatbot gracefully handles connection errors, login failures, and other issues.
- **Customization**: You can modify the chatbot's behavior by changing the rules in the `chatbot_rules` table.

