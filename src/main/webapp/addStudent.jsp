<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>

    <!-- Inline CSS for Styling -->
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        /* Form Container */
        form {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
        }

        /* Form Label Styles */
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            color: #555;
        }

        /* Input Styles */
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        /* Input Focus Effect */
        input[type="text"]:focus,
        input[type="number"]:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0px 0px 6px rgba(0, 123, 255, 0.4);
        }

        /* Button Styles */
        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: #0056b3;
            transform: scale(1.03);
        }
    </style>
</head>
<body>
    <h1>Add a New Student</h1>
    <form action="AddStudentServlet" method="post">
        <label for="name">Student Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="age">Age:</label>
        <input type="number" id="age" name="age" required>

        <button type="submit">Add Student</button>
    </form>
</body>
</html>
