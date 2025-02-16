<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Collection Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
            background-image: url('image.png');
 			 background-repeat: no-repeat;
  			background-attachment: fixed;
  			background-size: cover;
        }

        #form-container {
            max-width: 400px;
            margin: 50px auto;
            background-color: silver;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
        }

        input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
        }

        button {
            background-color: darkcyan;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        button:hover {
            background-color: #45a049;
        }

        #data-table {
            max-width: 600px;
            margin: 20px auto;
            background-color: silver;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: darkcyan;
            color: white;
        }
    </style>
</head>
<body>
    <div id="form-container">
    
    
    	
        <h2>Master Password Manager</h2>
       <!--   <form id="data-form" onsubmit="submitForm(event)"> -->
        <form id="data-form" ${pageContext.request.contextPath}/passwordmanager" id="data-form" method="post">
            <label Style="color : black" for="website"><b>Website</b></label>
            <input type="text" id="website" name="website" required>

            <label Style="color : black" for="username"> <b> Username </b></label>
            <input type="text" id="username" name="username" required>


            
			<button type="submit" id = "find">Find</button>
			
        </form>
    </div>

    <div id="data-table">
        <h2>Password Details</h2>
        <table>
            <thead>
                <tr>
                    <th>Website</th>
                    <th>Username</th>
                    <th>Password</th>
                </tr>
                 <tr>
    				<td>${website}</td>
    				<td>${username}</td>
    				<td>${password}</td>
  				</tr>
            </thead>
            <tbody id="data-body"></tbody>
        </table>
    </div>
<!--  
    <script>
        function submitForm(event) {
            event.preventDefault();

            const website = document.getElementById('website').value;
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            const tableBody = document.getElementById('data-body');
            const newRow = tableBody.insertRow(tableBody.rows.length);
            const cell1 = newRow.insertCell(0);
            const cell2 = newRow.insertCell(1);
            const cell3 = newRow.insertCell(2);

            cell1.textContent = website;
            cell2.textContent = username;
            cell3.textContent = password;

            document.getElementById('data-table').style.display = 'block';
        }
    </script>  -->
</body>
</html>
