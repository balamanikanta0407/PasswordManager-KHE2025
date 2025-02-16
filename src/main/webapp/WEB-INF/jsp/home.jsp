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
            background-image: url('image1.png');
  			background-repeat: no-repeat;
  			background-attachment: fixed;
  			background-size: 100% 100%;
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
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: none;
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
            background-color: #4caf50;
            color: white;
        }
        .rd
        {
        	background-color: dimgrey;
        	margin-top : 1px;
        }
        
        
        
    </style>
</head>
<body>
    <div id="form-container">
    	
        <h2>Master Password Page</h2>
       <!--   <form id="data-form" onsubmit="submitForm(event)"> -->
        <form action="${pageContext.request.contextPath}/home" id="data-form" method="post" autocomplete="on">
            <label Style="color : black" for="website"><b>Website</b></label>
            <input type="text" id="website" name="website">

            <label Style="color : black" for="username"><b>Username/Email</b></label>
            <input type="text" id="username" name="username">

             <label Style="color : black" for="password"><b>Password </b></label>  
            <input type="password" id="password" name="password" autocomplete="on">
            <!--    <button type="submit" id = "add">Add</button>  -->
            
			<button type="button" class="rd" onclick="createPassword()">Random password</button> <br><br>
         
         	<script>
         		const passwordBox = document.getElementById("password");
         		const length = 15;
         		const uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
         		const lowercase = "abcdefghijklmnopqrstuvwxyz";
         		const number= "0123456789";
         		const symbol = "@#$%^&*()_+~|}{[]></-=";
         		const allchars = uppercase + lowercase +number + symbol;
         		console.log("test");
         		
         		
         			
         		
         		
         		function createPassword()
         		{	
         			console.log("str");
         			let password="";
         			password += uppercase[Math.floor(Math.random() * uppercase.length)];
         			password += lowercase[Math.floor(Math.random() * lowercase.length)];
         			password += number[Math.floor(Math.random() * number.length)];
         			password += symbol[Math.floor(Math.random() * symbol.length)];
         			
         			while(length > password.length)
         			{
         				password += allchars[Math.floor(Math.random() * allchars.length)];
         			}
         			
         			passwordBox.value = password;
         			
         			console.log("trail " + password);
         		}
         			
         		
         		
         		
         		
         	</script> 
            <button type="submit" id = "add">Add Password</button>
            
            <button onclick="location.href='/passwordmanager'" type="button">Retrieve Passwords</button>
            
            <h2 style="color:green">${successMsg }</h2>
         
        </form>
        
       
			
    </div>

    <div id="data-table">
        <h2>Collected Data</h2>
        <table>
            <thead>
                <tr>
                    <th>Website</th>
                    <th>Username</th>
                    <th>Password</th>
                </tr>
            </thead>
            <tbody id="data-body"></tbody>
        </table>
    </div>

    
</body>
</html>
