<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (request.getParameter("submit") != null) {
        String id = request.getParameter("id");
        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");

        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/school_database", "root", "");
            preparedStatement = conn.prepareStatement("update student_table set studentName = ?, course = ?, fee = ? where id = ?");
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, course);
            preparedStatement.setString(3, fee);
            preparedStatement.setString(4, id);
            preparedStatement.executeUpdate();
%>
    <script>
        alert("Record updated successfully");
    </script >
<%
        } catch (Exception e) {
            e.printStackTrace();
%>
    <script>
        alert("Error updating record: <%= e.getMessage()%>");
    </script>
<%
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap.min.css" rel = "stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Edit Data</h1>
        <div class="row">
            <div class="col-sm-4"> <!--for form-->
                <form method="POST" action="#">
                    
                    <%
                        Connection conn = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                                
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost/school_database", "root", "");
                    
                        String id = request.getParameter("id");
                        preparedStatement = conn.prepareCall("select * from student_table where id = ?");
                        preparedStatement.setString(1, id);
                        resultSet = preparedStatement.executeQuery();
                        
                        while (resultSet.next()) {
                    %>
                    
                    <div alight="left">
                        <label class="form-label">Student Name</label>
                        <input type="text" class="form-control" placeholder="Student Name" value="<%=resultSet.getString("studentName")%>" name="sname" id="sname" required>
                    </div>
                    <div alight="left">
                        <label class="form-label">Course</label>
                        <input type="text" class="form-control" placeholder="Course" value="<%=resultSet.getString("course")%>" name="course" id="course" required>
                    </div>
                    <div alight="left">
                        <label class="form-label">Fee</label>
                        <input type="text" class="form-control" placeholder="Fee" value="<%=resultSet.getString("fee")%>" name="fee" id="fee" required>
                    </div>
                    
                    <%
                        }
                    %>
                    
                    <br>
                    
                    <div alight="right">
                        <input type="submit" id="submit" value="submit" name="submit" class="btn btn-info">
                        <input type="reset" id="reset" value="reset" name="reset" class="btn btn-warning">
                    </div>
                    
                    <div align="right">
                        <p><a href="index.jsp">Back</a></p>
                    </div>
                </form>
            </div>   
        </div> 
    </body>
</html>
