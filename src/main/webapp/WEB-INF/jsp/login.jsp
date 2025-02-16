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
        h4
        {
        
        	color : red;
        }


    
    </style>
</head>
<body>
	<div id="form-container">
	<h2>Password manager login</h2>
	
	
    <form  method="post" id="data-form">
        
        <label Style="color : black" for="username"><b>Username</b></label><br>
        <input type="text" name="userId" placeholder="Username">
        
        <label Style="color : black" for="password"><b>Password</b></label><br>
        <input type="password" name="password" placeholder="Password">
        
        <button>Submit</button>
        
        <h4>${errorMsg }</h4>
        
    </form>
    </div>
</body>
</html>