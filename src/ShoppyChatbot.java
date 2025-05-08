import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class ShoppyChatbot {
    private static Connection connection;
    private static String currentUser;
    private static Map<String, String> rules = new HashMap<>();

    public static void main(String[] args) {
        connectToDatabase();
        loadRulesFromDatabase();
        createLoginGUI();
    }

    private static void connectToDatabase() {
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/ShoppyDB", "root", "root");
            System.out.println("Connected to database.");
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "Failed to connect to the database. Exiting application.");
            System.exit(1);
        }
    }

    private static void loadRulesFromDatabase() {
        try {
            String query = "SELECT keyword, response FROM chatbot_rules";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String keyword = rs.getString("keyword").toLowerCase();
                String response = rs.getString("response");
                rules.put(keyword, response);
            }
            System.out.println("Rules loaded successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "Failed to load chatbot rules from the database.");
        }
    }

    private static void createLoginGUI() {
        JFrame frame = new JFrame("Shoppy - Login");
        frame.setSize(400, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        frame.add(panel);
        panel.setLayout(null);

        JLabel userLabel = new JLabel("Username:");
        userLabel.setBounds(10, 20, 80, 25);
        panel.add(userLabel);

        JTextField userText = new JTextField(20);
        userText.setBounds(100, 20, 165, 25);
        panel.add(userText);

        JLabel passwordLabel = new JLabel("Password:");
        passwordLabel.setBounds(10, 50, 80, 25);
        panel.add(passwordLabel);

        JPasswordField passwordText = new JPasswordField(20);
        passwordText.setBounds(100, 50, 165, 25);
        panel.add(passwordText);

        JButton loginButton = new JButton("Login");
        loginButton.setBounds(10, 80, 80, 25);
        panel.add(loginButton);

        JButton registerButton = new JButton("Register");
        registerButton.setBounds(100, 80, 100, 25);
        panel.add(registerButton);

        loginButton.addActionListener(e -> {
            String username = userText.getText();
            String password = new String(passwordText.getPassword());
            if (authenticateUser(username, password)) {
                currentUser = username;
                frame.dispose();
                createChatGUI();
            } else {
                JOptionPane.showMessageDialog(frame, "Invalid login. Please check your username or password.");
            }
        });

        registerButton.addActionListener(e -> {
            frame.dispose();
            createRegisterGUI();
        });

        frame.setVisible(true);
    }

    private static void createRegisterGUI() {
        JFrame frame = new JFrame("Shoppy - Register");
        frame.setSize(400, 400);
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        JPanel panel = new JPanel();
        panel.setLayout(new GridLayout(8, 2, 10, 10));
        frame.add(panel);

        JLabel firstNameLabel = new JLabel("First Name:");
        JTextField firstNameField = new JTextField(20);
        panel.add(firstNameLabel);
        panel.add(firstNameField);

        JLabel lastNameLabel = new JLabel("Last Name:");
        JTextField lastNameField = new JTextField(20);
        panel.add(lastNameLabel);
        panel.add(lastNameField);

        JLabel usernameLabel = new JLabel("Username:");
        JTextField usernameField = new JTextField(20);
        panel.add(usernameLabel);
        panel.add(usernameField);

        JLabel passwordLabel = new JLabel("Password:");
        JPasswordField passwordField = new JPasswordField(20);
        panel.add(passwordLabel);
        panel.add(passwordField);

        JLabel emailLabel = new JLabel("Email:");
        JTextField emailField = new JTextField(20);
        panel.add(emailLabel);
        panel.add(emailField);

        JLabel phoneLabel = new JLabel("Phone Number:");
        JTextField phoneField = new JTextField(15);
        panel.add(phoneLabel);
        panel.add(phoneField);

        JButton registerButton = new JButton("Register");
        JButton backButton = new JButton("Back");
        panel.add(registerButton);
        panel.add(backButton);

        registerButton.addActionListener(e -> {
            String firstName = firstNameField.getText();
            String lastName = lastNameField.getText();
            String username = usernameField.getText();
            String password = new String(passwordField.getPassword());
            String email = emailField.getText();
            String phone = phoneField.getText();

            if (registerUser(firstName, lastName, username, password, email, phone)) {
                JOptionPane.showMessageDialog(frame, "Registration successful. Please login.");
                frame.dispose();
                createLoginGUI();
            } else {
                JOptionPane.showMessageDialog(frame, "Registration failed. Username may already exist.");
            }
        });

        backButton.addActionListener(e -> {
            frame.dispose();
            createLoginGUI();
        });

        frame.setVisible(true);
    }

    private static boolean authenticateUser(String username, String password) {
        try {
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private static boolean registerUser(String firstName, String lastName, String username, String password, String email, String phone) {
        try {
            String query = "INSERT INTO users (first_name, last_name, username, password, email, phone_number) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, username);
            stmt.setString(4, password);
            stmt.setString(5, email);
            stmt.setString(6, phone);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private static void createChatGUI() {
        JFrame frame = new JFrame("Shoppy - Chat");
        frame.setSize(600, 600);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        frame.add(panel);
        panel.setLayout(new BorderLayout());

        JTextArea chatArea = new JTextArea();
        chatArea.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(chatArea);
        panel.add(scrollPane, BorderLayout.CENTER);

        JTextField inputField = new JTextField();
        panel.add(inputField, BorderLayout.SOUTH);

        inputField.addActionListener(e -> {
            String input = inputField.getText();
            chatArea.append("You: " + input + "\n");
            inputField.setText("");
            String response = handleUserInput(input);
            chatArea.append("Shoppy: " + response + "\n");

            saveConversation(currentUser, input, response);
        });

        createSettingsMenu(frame);

        frame.setVisible(true);
    }

    private static void createSettingsMenu(JFrame frame) {
        JMenuBar menuBar = new JMenuBar();

        JMenu settingsMenu = new JMenu("Settings");

        JMenuItem updateMenuItem = new JMenuItem("Update");
        JMenuItem deleteMenuItem = new JMenuItem("Delete");
        JMenuItem ordersMenuItem = new JMenuItem("Orders");
        JMenuItem viewConversationsMenuItem = new JMenuItem("View Conversations");

        updateMenuItem.addActionListener(e -> showUpdateDialog());
        deleteMenuItem.addActionListener(e -> showDeleteDialog());
        ordersMenuItem.addActionListener(e -> showOrdersDialog());
        viewConversationsMenuItem.addActionListener(e -> showConversationsDialog());

        settingsMenu.add(updateMenuItem);
        settingsMenu.add(deleteMenuItem);
        settingsMenu.add(ordersMenuItem);
        settingsMenu.add(viewConversationsMenuItem);

        menuBar.add(settingsMenu);
        frame.setJMenuBar(menuBar);
    }

    private static void showConversationsDialog() {
        try {
            String userIdQuery = "SELECT user_id FROM users WHERE username = ?";
            PreparedStatement userIdStmt = connection.prepareStatement(userIdQuery);
            userIdStmt.setString(1, currentUser);
            ResultSet userIdRs = userIdStmt.executeQuery();

            if (userIdRs.next()) {
                int userId = userIdRs.getInt("user_id");

                String conversationQuery = "SELECT user_message, bot_message, timestamp FROM conversations WHERE user_id = ?";
                PreparedStatement conversationStmt = connection.prepareStatement(conversationQuery);
                conversationStmt.setInt(1, userId);
                ResultSet rs = conversationStmt.executeQuery();

                StringBuilder conversations = new StringBuilder();
                while (rs.next()) {
                    conversations.append("You: ").append(rs.getString("user_message")).append("\n")
                            .append("Shoppy: ").append(rs.getString("bot_message")).append("\n")
                            .append("Time: ").append(rs.getTimestamp("timestamp")).append("\n\n");
                }

                if (conversations.length() == 0) {
                    conversations.append("No conversations found.");
                }

                JTextArea textArea = new JTextArea(conversations.toString());
                textArea.setEditable(false);
                JScrollPane scrollPane = new JScrollPane(textArea);

                JOptionPane.showMessageDialog(null, scrollPane, "Conversation History", JOptionPane.INFORMATION_MESSAGE);
            } else {
                JOptionPane.showMessageDialog(null, "User not found.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "Error retrieving conversations.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private static void saveConversation(String username, String userMessage, String botMessage) {
        try {
            String userIdQuery = "SELECT user_id FROM users WHERE username = ?";
            PreparedStatement userIdStmt = connection.prepareStatement(userIdQuery);
            userIdStmt.setString(1, username);
            ResultSet userIdRs = userIdStmt.executeQuery();

            if (userIdRs.next()) {
                int userId = userIdRs.getInt("user_id");

                String insertQuery = "INSERT INTO conversations (user_id, user_message, bot_message) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = connection.prepareStatement(insertQuery);
                insertStmt.setInt(1, userId);
                insertStmt.setString(2, userMessage);
                insertStmt.setString(3, botMessage);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String handleUserInput(String input) {
        input = input.toLowerCase();
        for (String keyword : rules.keySet()) {
            if (input.contains(keyword)) {
                return rules.get(keyword);
            }
        }
        return "I'm sorry, I didn't understand that. Can you rephrase?";
    }

    private static void showUpdateDialog() {
        JTextField emailField = new JTextField(20);
        JTextField phoneField = new JTextField(15);

        JPanel panel = new JPanel();
        panel.add(new JLabel("Email:"));
        panel.add(emailField);
        panel.add(Box.createVerticalStrut(15));
        panel.add(new JLabel("Phone:"));
        panel.add(phoneField);

        int result = JOptionPane.showConfirmDialog(null, panel, "Update Info", JOptionPane.OK_CANCEL_OPTION);
        if (result == JOptionPane.OK_OPTION) {
            String email = emailField.getText();
            String phone = phoneField.getText();
            try {
                String query = "UPDATE users SET email = ?, phone_number = ? WHERE username = ?";
                PreparedStatement stmt = connection.prepareStatement(query);
                stmt.setString(1, email);
                stmt.setString(2, phone);
                stmt.setString(3, currentUser);
                stmt.executeUpdate();
                JOptionPane.showMessageDialog(null, "Information updated successfully!");
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error updating information.");
            }
        }
    }

    private static void showDeleteDialog() {
        JPasswordField passwordField = new JPasswordField(20);

        JPanel panel = new JPanel();
        panel.add(new JLabel("Enter Password:"));
        panel.add(passwordField);

        int result = JOptionPane.showConfirmDialog(null, panel, "Delete Account", JOptionPane.OK_CANCEL_OPTION);
        if (result == JOptionPane.OK_OPTION) {
            String password = new String(passwordField.getPassword());
            if (authenticateUser(currentUser, password)) {
                try {
                    String query = "DELETE FROM users WHERE username = ?";
                    PreparedStatement stmt = connection.prepareStatement(query);
                    stmt.setString(1, currentUser);
                    stmt.executeUpdate();
                    JOptionPane.showMessageDialog(null, "Account deleted successfully.");
                    System.exit(0);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    JOptionPane.showMessageDialog(null, "Error deleting account.");
                }
            } else {
                JOptionPane.showMessageDialog(null, "Incorrect password.");
            }
        }
    }

    private static void showOrdersDialog() {
        try {
            String userIdQuery = "SELECT user_id FROM users WHERE username = ?";
            PreparedStatement userIdStmt = connection.prepareStatement(userIdQuery);
            userIdStmt.setString(1, currentUser);
            ResultSet userIdRs = userIdStmt.executeQuery();

            if (userIdRs.next()) {
                int userId = userIdRs.getInt("user_id");

                String orderQuery = "SELECT order_date, product_name, amount, status FROM orders WHERE user_id = ?";
                PreparedStatement orderStmt = connection.prepareStatement(orderQuery);
                orderStmt.setInt(1, userId);
                ResultSet rs = orderStmt.executeQuery();

                StringBuilder orders = new StringBuilder();
                while (rs.next()) {
                    orders.append("Date: ").append(rs.getTimestamp("order_date"))
                            .append(", Product: ").append(rs.getString("product_name"))
                            .append(", Amount: £").append(rs.getBigDecimal("amount"))
                            .append(", Status: ").append(rs.getString("status"))
                            .append("\n");
                }

                if (orders.length() == 0) {
                    orders.append("No orders found.");
                }

                JOptionPane.showMessageDialog(null, orders.toString(), "Your Orders", JOptionPane.INFORMATION_MESSAGE);
            } else {
                JOptionPane.showMessageDialog(null, "User not found.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "Error retrieving orders.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}