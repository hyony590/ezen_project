<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>토이스토리</title>



</head>
<body>

	<!-- header -->
	<div id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	
	<!-- body -->
	<div id="container">
		<tiles:insertAttribute name="body"/>
	</div>
	
	<!-- footer --> 
	<tiles:insertAttribute name="footer"/>
	
</body>
</html>