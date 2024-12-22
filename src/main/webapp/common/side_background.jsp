<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>side background</title>
</head>
<body style="margin: 0; padding: 0;">
    <div class="side_background" style="position: relative;">
        <div class="left_side" style="position: absolute; left: 0; width: 145px; top: -80px; ">
            <div style="position: fixed; width: 146px; height: 120vh; background-color: #ccc; box-shadow: inset -5px -5px 10px rgba(0, 0, 0, 0.5);"></div>
        </div>
        <div class="right_side" style="position: absolute; right: 1px; top: -80px; width: 145px; ">
            <div style="position: fixed; width: 148px; height: 120vh; background-color: #ccc; box-shadow: inset 5px 5px 10px rgba(0, 0, 0, 0.5);"></div>
        </div>
    </div>
</body>
</html>