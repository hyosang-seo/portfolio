<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <meta charset="UTF-8">
  
    <style>
        html{border:1px solid gray;}
        div{
            border:5px solid tomato;
            margin:10px;
        }
        #me{
            position: relative;
            left:100px;
            top:100px;
        }
    </style>
  </head>
  <body>
    <div id="other">other</div>
    <div id="parent">
       parent
       <div id="me">me</div>
    </div>
  </body>
</html>